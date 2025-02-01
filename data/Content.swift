@Model public class Content: Decodable {
  public enum Kind: String, Codable { case info, textfield }

  public var module: Module?

  public var type: Kind

  public var image: String
  public var title: String
  @Attribute(.unique) public var content: String

  public var index: Int

  public var answer: String?

  public init(type: Kind, image: String, title: String, content: String, index: Int) {
    self.type = type
    self.image = image
    self.title = title
    self.content = content
    self.index = index
  }

  public required convenience init(from decoder: Decoder) throws {
    enum CodingKeys: String, CodingKey { case type, image, title, content, index }
    let container = try decoder.container(keyedBy: CodingKeys.self)

    self.init(
      type: try container.decode(Kind.self, forKey: .type),
      image: try container.decode(String.self, forKey: .image),
      title: try container.decode(String.self, forKey: .title),
      content: try container.decode(String.self, forKey: .content),
      index: try container.decode(Int.self, forKey: .index)
    )
  }
}
