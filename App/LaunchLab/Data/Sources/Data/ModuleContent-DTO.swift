//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

public extension ModuleContent {
  struct DTO: Codable {
    public let title, image, content: String
    public let type: ContentType

    public init(title: String, image: String, content: String, type: ContentType) {
      self.title = title
      self.image = image
      self.content = content
      self.type = type
    }
  }

  convenience init(_ dto: DTO, module: Module) {
    self.init(context: CoreDataStack.shared.mainContext)

    self.module = module
    title = dto.title
    image = dto.image
    content = dto.content
    type = dto.type.rawValue
  }
}
