//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import CoreData
import Foundation

@objc(ModulePageContent)
public class ModulePageContent: NSManagedObject, Codable {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<ModulePageContent> {
    NSFetchRequest<ModulePageContent>(entityName: "ModulePageContent")
  }

  @NSManaged public var title: String
  @NSManaged public var infoText: String
  @NSManaged public var imageName: String
  @NSManaged public var pathIndex: Int16
  @NSManaged public var question: String?
  @NSManaged public var userAnswer: String?
  @NSManaged public var module: Module

  public required convenience init(from decoder: Decoder) throws {
    self.init(context: CoreDataStack.shared.mainContext)

    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.title = try container.decode(String.self, forKey: .title)
    self.infoText = try container.decode(String.self, forKey: .infoText)
    self.imageName = try container.decode(String.self, forKey: .imageName)
    self.pathIndex = try container.decode(Int16.self, forKey: .pathIndex)
    self.question = try container.decodeIfPresent(String.self, forKey: .question)
    self.userAnswer = try container.decodeIfPresent(String.self, forKey: .userAnswer)
  }

  public func encode(to encoder: any Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)

    try container.encode(title, forKey: .title)
    try container.encode(infoText, forKey: .infoText)
    try container.encode(imageName, forKey: .imageName)
    try container.encode(pathIndex, forKey: .pathIndex)
    try container.encode(question, forKey: .question)
    try container.encode(userAnswer, forKey: .userAnswer)
  }

  public class func createModulePageContent(from dto: ModulePageContentDTO, module: Module) {
    let newModulePageContent = ModulePageContent(context: CoreDataStack.shared.mainContext)
    newModulePageContent.title = dto.title
    newModulePageContent.infoText = dto.infoText
    newModulePageContent.imageName = dto.imageName
    newModulePageContent.question = dto.question
    newModulePageContent.userAnswer = dto.userAnswer
    newModulePageContent.module = module
   }

  private enum CodingKeys: String, CodingKey {
    case title
    case infoText
    case imageName
    case question
    case userAnswer
    case pathIndex
  }
}
