//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import CoreData
import Data
import Testing

@testable import LaunchLab

class ModuleContentTests {
  @Test("correct content type", arguments: [
    "info", "textfield"
  ])
  func parseCorrectType(type: String) async throws {
    #expect(ModuleContent.ContentType(rawValue: type) != nil)
  }

  @Test("incorrect content type", arguments: [
    "hullo"
  ])
  func parseIncorrectType(type: String) async throws {
    #expect(ModuleContent.ContentType(rawValue: type) == nil)
  }

  @Test("parsing from DTO", arguments: [
    ModuleContent.DTO(title: "dto", image: "image", content: "content", type: .info),
    ModuleContent.DTO(title: "another dto", image: "image2", content: "what?", type: .textfield)
  ])
  func parseFromDTO(dto: ModuleContent.DTO) async throws {
    let content = ModuleContent(dto, module: Module.example(Int.random(in: 50...100)))

    #expect(content.title == dto.title)
    #expect(content.image == dto.image)
    #expect(content.content == dto.content)
    #expect(content.type == dto.type.rawValue)
  }
}

extension ModuleContent.DTO: @unchecked @retroactive Sendable {}
