//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//
// swiftlint:disable force_unwrapping

import Combine
import CoreData
import OSLog
import Styleguide
import UserNotifications

/*
 This is the CoreDataManager used by the app. It saves changes to disk.

 Managers can do operations via the:
 - `mainContext` with interacts on the main UI thread, or
 - `backgroundContext` with has a separate queue for background processing
 */
public class CoreDataStack: @unchecked Sendable {
  public static let shared = CoreDataStack()

  public let persistentContainer: NSPersistentContainer
  public let backgroundContext: NSManagedObjectContext
  public let mainContext: NSManagedObjectContext
  private var cancellables = Set<AnyCancellable>()

  private init() {
    ValueTransformer.setValueTransformer(QuestionAnswerTransformer(), forName: NSValueTransformerName("QuestionAnswerTransformer"))

    let modelURL = Bundle.module.url(forResource: "Launchlab", withExtension: "momd")!
    let model = NSManagedObjectModel(contentsOf: modelURL)!
    persistentContainer = NSPersistentContainer(name: "Launchlab", managedObjectModel: model)

    let storeDescription = persistentContainer.persistentStoreDescriptions.first
    storeDescription?.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
    storeDescription?.setOption(true as NSNumber, forKey: NSMigratePersistentStoresAutomaticallyOption)
    storeDescription?.setOption(true as NSNumber, forKey: NSInferMappingModelAutomaticallyOption)

    mainContext = persistentContainer.viewContext
    mainContext.automaticallyMergesChangesFromParent = true

    backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    backgroundContext.parent = mainContext

    persistentContainer.loadPersistentStores { _, error in
      guard error == nil else {
        fatalError("Failed to load store: \(error?.localizedDescription ?? "")")
      }
    }

    subscribeToCloudKitEvents()
  }

  public func destroyPersistentStore() {
    persistentContainer.loadPersistentStores { description, _ in
      if let url = description.url {
        let coordinator = self.persistentContainer.persistentStoreCoordinator
        try? coordinator.destroyPersistentStore(at: url, type: .sqlite)
        _ = try? coordinator.addPersistentStore(type: .sqlite, at: url)
      }
    }
  }

  public func save() {
    guard mainContext.hasChanges else { return }

    mainContext.performAndWait {
      do {
        try mainContext.save()
        try persistentContainer.viewContext.setQueryGenerationFrom(.current)

        print("Successfully saved changes to Core Data and triggered iCloud sync.")
      } catch {
        print("Error saving context: \(error.localizedDescription)")
      }
    }
  }

  public func deleteAllObjects<T: NSManagedObject>(ofType entityType: T.Type, in context: NSManagedObjectContext) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: entityType))
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    do {
      try context.execute(deleteRequest)
    } catch {
      print("Failed to delete all objects of type \(entityType): \(error.localizedDescription)")
    }
  }

  @objc
  private func storeRemoteChange(_ notification: Notification) {
    mainContext.perform {
      print("Merging changes from iCloud...")
      self.mainContext.mergeChanges(fromContextDidSave: notification)
    }
  }

  private func subscribeToCloudKitEvents() {
    UserNotifications.NotificationCenter.default
      .publisher(for: .NSPersistentStoreRemoteChange)
      .sink { notification in
        self.storeRemoteChange(notification)
      }
      .store(in: &cancellables)
  }
}

public extension CoreDataStack {
  func populateModulesIfNeeded() {
    CoreDataStack.shared.mainContext.refreshAllObjects()

    let fetchRequest: NSFetchRequest<Module> = Module.fetchRequest()
    do {
      let existingModules = try mainContext.fetch(fetchRequest)
      if !existingModules.isEmpty {
        print("Modules already exist, skipping JSON import.")
        return
      }
    } catch {
      print("Failed to fetch existing modules: \(error.localizedDescription)")
      return
    }

    guard let url = Bundle.main.url(
      forResource: "Modules",
      withExtension: "json"
    ),
      let data = try? Data(contentsOf: url)
    else {
      print("Failed to load Modules.json")
      return
    }

    let decoder = JSONDecoder()
    do {
      let dtos = try decoder.decode([Module.DTO].self, from: data)
      for dto in dtos.sorted(by: { $0.index < $1.index }) {
        _ = Module(dto)
        try? CoreDataStack.shared.mainContext.save()
      }

      CoreDataStack.shared.save()
      print("Successfully populated Core Data with modules from JSON.")
    } catch {
      print("Failed to decode Modules.json: \(error.localizedDescription)")
    }
  }
}
