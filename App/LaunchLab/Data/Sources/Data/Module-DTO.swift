//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Foundation

extension Module {
  public struct DTO: Codable {
    public let index: Int,
               title: String,
               desc: String

    public let image: String,
               collectable: String

    public let progress: Int,
               content: [ModuleContent.DTO]

    public init(
      index: Int,
      title: String,
      desc: String,
      image: String,
      collectable: String,
      progress: Int,
      content: [ModuleContent.DTO]
    ) {
      self.index = index
      self.title = title
      self.desc = desc
      self.image = image
      self.collectable = collectable
      self.progress = progress
      self.content = content
    }
  }

  public convenience init(_ dto: DTO) {
    self.init(context: CoreDataStack.shared.mainContext)

    index = Int16(dto.index)
    title = dto.title
    desc = dto.desc
    image = dto.image
    collectable = dto.collectable
    progress = Int16(dto.progress)
    _ = dto.content.map { ModuleContent($0, module: self) }
  }
}
