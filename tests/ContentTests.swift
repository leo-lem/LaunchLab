import Data
import Testing

@testable import LaunchLab

class ContentTests {
  @Test("correct content type", arguments: [
    "info", "textfield"
  ])
  func parseCorrectType(type: String) async throws {
    #expect(Content.Kind(rawValue: type) != nil)
  }

  @Test("incorrect content type", arguments: [
    "hullo"
  ])
  func parseIncorrectType(type: String) async throws {
    #expect(Content.Kind(rawValue: type) == nil)
  }
}
