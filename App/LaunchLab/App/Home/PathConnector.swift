//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import SwiftUI

struct PathConnector: View {
  @ObservedObject var module: Module
  let nextModulePosition: String
  let total: Int

  var body: some View {
    Canvas { context, _ in
      var path = Path()
      let current = PathNode.PositionHelper.position(for: module.pathPosition, index: module.index, moduleCount: total)

      if module.index < total {
        let next = PathNode.PositionHelper.position(for: nextModulePosition, index: module.index + 1, moduleCount: total)

        let controlPoint1 = CGPoint(
          x: (current.x + next.x) / 2 + 100,
          y: current.y - 100
        )

        let controlPoint2 = CGPoint(
          x: (current.x + next.x) / 2 - 100,
          y: next.y + 120
        )

        path.move(to: current)
        path.addCurve(to: next, control1: controlPoint1, control2: controlPoint2)

        context.stroke(
          path,
          with: .color(Color(hex: "#A0E2EA").opacity(module.isCompleted ? 1 : 0.2)),
          style: StrokeStyle(lineWidth: 10, lineCap: .round, dash: [15, 40])
        )
      }
    }
  }
}
