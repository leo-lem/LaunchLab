@Model public class Module: @unchecked Sendable, Decodable {
  public enum Kind: String, Codable { case module, document, consultation }
  public enum Position: String, Codable { case leading, center, trailing }

  public var type: Kind

  public var image: String
  public var title: String
  public var desc: String

  @Attribute(.unique) public var index: Int
  public var position: Position

  public var progress: Int

  public var content: [Content]

  public init(
    type: Kind,
    image: String,
    title: String,
    desc: String,
    index: Int,
    position: Position,
    progress: Int,
    content: [Content]
  ) {
    self.type = type
    self.image = image
    self.title = title
    self.desc = desc
    self.index = index
    self.position = position
    self.progress = progress
    self.content = content
  }

  public var length: Int { type == .module ? content.count : 1 }
  public var isCompleted: Bool { progress >= length }
  public var isStarted: Bool { progress > 0 }
  public var sortedContent: [Content] { content.sorted { $0.index < $1.index } }

  public required convenience init(from decoder: any Decoder) throws {
    enum CodingKeys: String, CodingKey {
      case type, image, title, desc, index, position, content
    }

    let container = try decoder.container(keyedBy: CodingKeys.self)

    self.init(
      type: try container.decode(Kind.self, forKey: .type),
      image: try container.decode(String.self, forKey: .image),
      title: try container.decode(String.self, forKey: .title),
      desc: try container.decode(String.self, forKey: .desc),
      index: try container.decode(Int.self, forKey: .index),
      position: try container.decode(Position.self, forKey: .position),
      progress: 0,
      content: try container.decode([Content].self, forKey: .content)
    )
  }
}
