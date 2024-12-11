//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//
// swiftlint: disable force_unwrapping

import CoreData
import Data
import XCTest

@testable import LaunchLab

final class ModuleTests: XCTestCase {
  var managedObjectContext: NSManagedObjectContext!

  override func setUp() {
    super.setUp()

    managedObjectContext = CoreDataStack.shared.backgroundContext
  }

  override func tearDown() {
    managedObjectContext = nil
    super.tearDown()
  }

  func testCreateModuleFromDTO() {
    // Given
    let dto = Module.DTO(
      index: 3,
      title: "DTO Module",
      desc: "Created from DTO",
      image: "dtoPlanet.png",
      collectable: "dtoImage.png",
      progress: 0,
      content: []
    )

    // When
    let module = Module(dto)

    // Then
    XCTAssertEqual(module.index, 3)
    XCTAssertEqual(module.title, "DTO Module")
    XCTAssertEqual(module.desc, "Created from DTO")
    XCTAssertEqual(module.progress, 0)
    XCTAssertEqual(module.collectable, "dtoImage.png")
    XCTAssertEqual(module.image, "dtoPlanet.png")
  }

  func testModulePersistence() throws {
    // Given
    let module = Module(context: managedObjectContext)
    module.title = "Persistent Module"
    module.desc = "This is persisted."
    module.progress = 0
    module.index = 1
    module.collectable = "persistImage.png"
    module.image = "persistPlanet.png"

    try managedObjectContext.save()

    // When
    let fetchRequest: NSFetchRequest<Module> = Module.fetchRequest()
    let fetchedModules = try managedObjectContext.fetch(fetchRequest)
    let fetchedModule = fetchedModules.first { $0.title == "Persistent Module" }!

    // Then
    XCTAssertEqual(fetchedModule.title, "Persistent Module")
    XCTAssertEqual(fetchedModule.desc, "This is persisted.")
    XCTAssertEqual(fetchedModule.collectable, "persistImage.png")
    XCTAssertEqual(fetchedModule.image, "persistPlanet.png")
  }
}
