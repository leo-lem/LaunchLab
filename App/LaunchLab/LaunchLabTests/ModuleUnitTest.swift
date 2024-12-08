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

  func testModuleCodableConformance() throws {
    // Given
    let json = """
    {
        "moduleName": "Test Module",
        "moduleDescription": "This is a test module.",
        "isCompleted": true,
        "currentPageIndex": 2,
        "pathIndex": 1,
        "collectableImageString": "image1.png",
        "planetImageString": "planet1.png"
    }
    """
    let jsonData = json.data(using: .utf8)!

    // When
    let decoder = JSONDecoder()
    let decodedModule = try decoder.decode(Module.self, from: jsonData)

    // Then
    XCTAssertEqual(decodedModule.moduleName, "Test Module")
    XCTAssertEqual(decodedModule.moduleDescription, "This is a test module.")
    XCTAssertTrue(decodedModule.isCompleted)
    XCTAssertEqual(decodedModule.currentPageIndex, 2)
    XCTAssertEqual(decodedModule.pathIndex, 1)
    XCTAssertEqual(decodedModule.collectableImageString, "image1.png")
    XCTAssertEqual(decodedModule.planetImageString, "planet1.png")
  }

  func testCreateModuleFromDTO() {
    // Given
    let dto = ModuleDTO(
      moduleName: "DTO Module",
      moduleDescription: "Created from DTO",
      isCompleted: false,
      currentPageIndex: 0,
      pathIndex: 3,
      pageContent: [],
      collectableImageString: "dtoImage.png",
      planetImageString: "dtoPlanet.png"
    )

    // When
    let module = Module.createModule(from: dto)

    // Then
    XCTAssertEqual(module.moduleName, "DTO Module")
    XCTAssertEqual(module.moduleDescription, "Created from DTO")
    XCTAssertFalse(module.isCompleted)
    XCTAssertEqual(module.currentPageIndex, 0)
    XCTAssertEqual(module.pathIndex, 3)
    XCTAssertEqual(module.collectableImageString, "dtoImage.png")
    XCTAssertEqual(module.planetImageString, "dtoPlanet.png")
  }

  func testModulePersistence() throws {
    // Given
    let module = Module(context: managedObjectContext)
    module.moduleName = "Persistent Module"
    module.moduleDescription = "This is persisted."
    module.isCompleted = false
    module.currentPageIndex = 0
    module.pathIndex = 1
    module.collectableImageString = "persistImage.png"
    module.planetImageString = "persistPlanet.png"

    try managedObjectContext.save()

    // When
    let fetchRequest: NSFetchRequest<Module> = Module.fetchRequest()
    let fetchedModules = try managedObjectContext.fetch(fetchRequest)
    let fetchedModule = fetchedModules.first { $0.moduleName == "Persistent Module" }!

    // Then
    XCTAssertEqual(fetchedModule.moduleName, "Persistent Module")
    XCTAssertEqual(fetchedModule.moduleDescription, "This is persisted.")
    XCTAssertEqual(fetchedModule.collectableImageString, "persistImage.png")
    XCTAssertEqual(fetchedModule.planetImageString, "persistPlanet.png")
  }
}
