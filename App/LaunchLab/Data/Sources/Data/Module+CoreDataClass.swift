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
  @NSManaged public var pathPosition: String
  @NSManaged public var progress: Int16
  @NSManaged public var questionAndAnswer: [String: String]
  @NSManaged public var content: Set<ModuleContent>

  public var length: Int { content.count }
  public var isCompleted: Bool { type == "module" ? progress >= length : progress > 0 }
}

@objc(QuestionAnswerTransformer)
class QuestionAnswerTransformer: ValueTransformer {
  override class func transformedValueClass() -> AnyClass {
    NSData.self
  }

  override class func allowsReverseTransformation() -> Bool {
    true
  }

  override func transformedValue(_ value: Any?) -> Any? {
    guard let itemTime = value as? [String: String] else {
      return nil
    }

    do {
      let data = try JSONEncoder().encode(itemTime)
      return data
    } catch {
      print("Failed to encode ItemTime: \(error)")

      return nil
    }
  }

  override func reverseTransformedValue(_ value: Any?) -> Any? {
    guard let data = value as? Data else {
      return nil
    }

    do {
      let itemTime = try JSONDecoder().decode([String: String].self, from: data)
      return itemTime
    } catch {
      print("Failed to encode ItemTime: \(error)")
      return nil
    }
  }
}
