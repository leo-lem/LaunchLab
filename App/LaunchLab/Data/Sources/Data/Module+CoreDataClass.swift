//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import CoreData
import Foundation

@objc(Module)
public class Module: NSManagedObject, Codable {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Module> {
    NSFetchRequest<Module>(entityName: "Module")
  }

  @NSManaged public var moduleName: String
  @NSManaged public var collectableImageString: String
  @NSManaged public var planetImageString: String
  @NSManaged public var moduleDescription: String
  @NSManaged public var isCompleted: Bool
  @NSManaged public var currentPageIndex: Int16
  @NSManaged public var pathIndex: Int16
  @NSManaged public var pageContent: [ModulePageContent]

  public required convenience init(from decoder: Decoder) throws {
    self.init(context: CoreDataStack.shared.mainContext)

    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.moduleName = try container.decode(String.self, forKey: .moduleName)
    self.moduleDescription = try container.decode(String.self, forKey: .moduleDescription)
    self.isCompleted = try container.decode(Bool.self, forKey: .isCompleted)
    self.currentPageIndex = try container.decode(Int16.self, forKey: .currentPageIndex)
    self.pathIndex = try container.decode(Int16.self, forKey: .pathIndex)
    self.collectableImageString = try container.decode(String.self, forKey: .collectableImageString)
    self.planetImageString = try container.decode(String.self, forKey: .planetImageString)
  }

  public func encode(to encoder: any Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)

    try container.encode(moduleName, forKey: .moduleName)
    try container.encode(moduleDescription, forKey: .moduleDescription)
    try container.encode(isCompleted, forKey: .isCompleted)
    try container.encode(currentPageIndex, forKey: .currentPageIndex)
    try container.encode(pathIndex, forKey: .pathIndex)
    try container.encode(collectableImageString, forKey: .collectableImageString)
    try container.encode(planetImageString, forKey: .planetImageString)
  }

  public class func createModule(from dto: ModuleDTO) -> Module {
    let newModule = Module(context: CoreDataStack.shared.mainContext)
    newModule.moduleName = dto.moduleName
    newModule.moduleDescription = dto.moduleDescription
    newModule.isCompleted = false
    newModule.pathIndex = Int16(dto.pathIndex)
    newModule.currentPageIndex = Int16(dto.currentPageIndex)
    newModule.collectableImageString = dto.collectableImageString
    newModule.planetImageString = dto.planetImageString

    CoreDataStack.shared.save()
    return newModule
  }

  private enum CodingKeys: String, CodingKey {
    case moduleName
    case moduleDescription
    case isCompleted
    case currentPageIndex
    case pathIndex
    case collectableImageString
    case planetImageString
  }
}
