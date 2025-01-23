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
        image: "ideas",
        collectable: "collectable\(index)",
        pathPosition: index.isMultiple(of: 2) ? "left" : index.isMultiple(of: 3) ? "center" : "right",
        progress: 0,
        content: [
          ModuleContent.DTO(title: "What do you think?", image: "wand.and.rays", content: "Create a mind map for a problem you observe. Write down at least five possible ideas to solve it.", type: .textfield)
        ]
    ))
  }
}
