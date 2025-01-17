//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//
// swiftlint:disable line_length

import Data

extension Module {
  static let examples = (0...7).map(example)

  static func example(_ index: Int) -> Module {
    Module(Module.DTO(
        index: index,
        title: "Example Module \(index)",
        desc: "This is an example module for previewing purposes.",
        type: index.isMultiple(of: 4) ? "consultation" : index.isMultiple(of: 2) ? "document" : "module",
        image: "module\(index)",
        collectable: "collectable\(index)",
        pathPosition: index.isMultiple(of: 2) ? "left" : index.isMultiple(of: 3) ? "center" : "right",
        progress: 0,
        content: [
          ModuleContent.DTO(title: "Hello!", image: "lightbulb.circle.fill", content: "Explore methods to generate and refine innovative ideas.\nThe best ideas emerge when you think freely and creatively. Use brainstorming techniques such as:\n\n- **Mind Mapping**: Write your central theme in the middle and expand it with associations.\n- **Thinking Hats**: View your problem from different perspectives (e.g., positive, critical, emotional).\n- **Reverse Thinking**: Consider how you would worsen the problem, then find solutions to achieve the opposite.", type: .info),
          ModuleContent.DTO(title: "What do you think?", image: "wand.and.rays", content: "Create a mind map for a problem you observe. Write down at least five possible ideas to solve it.", type: .textfield)
        ]
    ))
  }
}
