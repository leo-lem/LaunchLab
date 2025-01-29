//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import SwiftUI

extension Path {
  struct Node: View {
    let module: Module,
        total: Int

    var body: some View {
      ZStack {
        Image(module.image)
          .resizable()
          .scaledToFit()
          .frame(maxHeight: module.type == "module" ? 120 : 80)
          .scaleEffect(module.type == "module" ? 1 : 0.8)
          .position(position.point(total: total))

        //        if let collectable = module.collectable {
        //          Image(collectable)
        //            .resizable()
        //            .scaledToFit()
        //            .frame(maxWidth: 40, maxHeight: 100)
        //            .opacity(module.isCompleted ? 1 : 0.25)
        //            .shadow(color: .black, radius: 10)
        //            .position(position.opposite.point(total: total))
        //        }
      }
    }

    private var position: Path.Position { Path.Position(module) }
  }
}
