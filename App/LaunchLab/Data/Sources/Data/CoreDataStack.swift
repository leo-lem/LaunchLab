//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//
// swiftlint:disable force_unwrapping

import CoreData

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

  private init() {
    let modelURL = Bundle.module.url(forResource: "Launchlab", withExtension: ".momd")!
    let model = NSManagedObjectModel(contentsOf: modelURL)!

    persistentContainer = NSPersistentContainer(name: "Launchlab", managedObjectModel: model)

    let description = persistentContainer.persistentStoreDescriptions.first
    description?.type = NSSQLiteStoreType

    persistentContainer.loadPersistentStores { _, error in
      guard error == nil else {
        fatalError("was unable to load store \(error!)")
      }
    }

    mainContext = persistentContainer.viewContext

    backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    backgroundContext.parent = mainContext
  }

  public func save() {
    mainContext.performAndWait {
      do {
        try mainContext.save()
      } catch {
        print("ERROR SAVING: \(error.localizedDescription)")
      }
    }
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
}

extension CoreDataStack {
  public func populateModulesIfNeeded() {
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
      forResource: "Modules-\(Bundle.main.preferredLocalizations.first ?? "en")",
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
