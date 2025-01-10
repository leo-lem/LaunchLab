//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import CoreData
import Foundation

@objc(Module)
public class Module: NSManagedObject {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Module> {
    NSFetchRequest<Module>(entityName: "Module")
  }

  @NSManaged public var index: Int16
  @NSManaged public var title: String
  @NSManaged public var desc: String
  @NSManaged public var type: String
  @NSManaged public var image: String
  @NSManaged public var collectable: String?
  @NSManaged public var progress: Int16
  @NSManaged public var content: Set<ModuleContent>

  public var length: Int { content.count }
  public var isCompleted: Bool { progress >= length }
}
