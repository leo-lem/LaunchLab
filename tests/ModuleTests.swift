//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//
// swiftlint: disable force_unwrapping

import CoreData
import Data
import Testing

@testable import LaunchLab

struct ModuleTests {
  @Test("creating from DTO", arguments: [
    Module.DTO(
      index: 150,
      title: "DTO Module",
      desc: "Created from DTO",
      type: "module",
      image: "ideas",
      collectable: "collectable1",
      pathPosition: "right",
      progress: 0,
      content: []
    )
  ])
  func testCreateModuleFromDTO(dto: Module.DTO) {
    let module = Module(dto)

    #expect(module.index == dto.index)
    #expect(module.title == dto.title)
    #expect(module.desc == dto.desc)
    #expect(module.progress == dto.progress ?? -1)
    #expect(module.collectable == dto.collectable)
    #expect(module.image == dto.image)
  }

  @Test("persistence")
  func testModulePersistence() throws {
    let context = CoreDataStack.shared.backgroundContext
    let module = Module(context: context)
    module.title = "Persistent Module"
    module.desc = "This is persisted."
    module.progress = 0
    module.index = 40
    module.collectable = "collectable3"
    module.image = "consultation"
    try context.save()

    // When
    let fetchRequest: NSFetchRequest<Module> = Module.fetchRequest()
    let fetchedModules = try context.fetch(fetchRequest)
    let fetched = fetchedModules.first { $0.title == "Persistent Module" }!

    // Then
    #expect(fetched == module)
    #expect(fetched.title == module.title)
    #expect(fetched.desc == module.desc)
    #expect(fetched.progress == module.progress)
    #expect(fetched.index == module.index)
    #expect(fetched.collectable == module.collectable)
    #expect(fetched.image == module.image)
  }

  @Test("is completed")
  func testIsCompleted() {
    let module = Module.example(Int.random(in: 50...100))
    #expect(!module.isCompleted)
    module.progress = Int16(module.length)
    #expect(module.isCompleted)
  }
}

extension Module.DTO: @unchecked @retroactive Sendable {}
