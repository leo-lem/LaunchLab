//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import CoreData
import Foundation

@objc(ModuleContent)
public class ModuleContent: NSManagedObject {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<ModuleContent> {
    NSFetchRequest<ModuleContent>(entityName: "ModuleContent")
  }

  @NSManaged public var module: Module
  @NSManaged public var title: String
  @NSManaged public var image: String
  @NSManaged public var content: String
  @NSManaged public var type: String

  public var contentType: ContentType { ContentType(rawValue: type) ?? .info }

  public enum ContentType: String, Codable {
    case info, textfield
  }
}
