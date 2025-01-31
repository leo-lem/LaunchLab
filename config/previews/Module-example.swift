//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data

public extension Module {
  static let examples = (0 ... 7).map(example)

  static func example(_ index: Int) -> Module {
    Module(
      type: index.isMultiple(of: 4) ? .consultation : index.isMultiple(of: 2) ? .document : .module,
      image: "ideas",
      title: "Example Module \(index)",
      desc: "This is an example module for previewing purposes.",
      index: index,
      position: index.isMultiple(of: 2) ? .leading : index.isMultiple(of: 3) ? .center : .trailing,
      progress: 0,
      content: [
        Content(
          type: .textfield,
          image: "wand.and.rays",
          title: "What do you think?",
          content: "Create a mind map for a problem you observe. Write down at least five possible ideas to solve it.",
          index: 0
        )
      ]
    )
  }
}
