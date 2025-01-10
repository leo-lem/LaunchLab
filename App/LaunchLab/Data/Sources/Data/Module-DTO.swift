//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Foundation

public extension Module {
  struct DTO: Codable {
    public let index: Int
    public let title: String
    public let desc: String
    public let type: String
    public let image: String
    public let collectable: String?
    public let pathPosition: String
    public let progress: Int
    public let content: [ModuleContent.DTO]

    public init(
      index: Int,
      title: String,
      desc: String,
      type: String,
      image: String,
      collectable: String?,
      pathPosition: String,
      progress: Int,
      content: [ModuleContent.DTO]
    ) {
      self.index = index
      self.title = title
      self.desc = desc
      self.type = type
      self.image = image
      self.collectable = collectable
      self.pathPosition = pathPosition
      self.progress = progress
      self.content = content
    }
  }

  convenience init(_ dto: DTO) {
    self.init(context: CoreDataStack.shared.mainContext)

    index = Int16(dto.index)
    title = dto.title
    desc = dto.desc
    type = dto.type
    image = dto.image
    collectable = dto.collectable
    pathPosition = dto.pathPosition
    progress = Int16(dto.progress)
    _ = dto.content.map { ModuleContent($0, module: self) }
  }
}
