//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import SwiftUI
import UIComponents

extension Path {
  struct Node: View {
    @Binding var selection: Module?
    let module: Module,
        total: Int

    var body: some View {
      HStack {
        PathNodeView(
          gradient: module.gradient,
          isRocketImage: module.type == "module",
          imageString: module.image
        ) {
          selection = module
        }
        .position(position.point(total: total))

        Group {
          if let collectable = module.collectable {
            Image(collectable)
              .resizable()
              .scaledToFit()
              .opacity(module.isCompleted ? 1 : 0.1)
              .frame(maxWidth: 40, maxHeight: 100)
          }
        }
        .position(position.opposite.point(total: total))
      }
    }

    private var position: Path.Position { Path.Position(module) }
  }
}
