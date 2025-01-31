//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import SwiftUI

extension Path {
  struct Connector: View {
    let current: Path.Position?,
        next: Path.Position?,
        isComplete: Bool,
        total: Int

    var body: some View {
      Canvas { context, _ in
        var path = SwiftUI.Path()

        path.move(to: start)
        path.addCurve(
          to: end,
          control1: CGPoint(
            x: (start.x + end.x) / 2 + 100,
            y: start.y - 100
          ),
          control2: CGPoint(
            x: (start.x + end.x) / 2 - 100,
            y: end.y + 120
          )
        )

        context.stroke(
          path,
          with: .color(Color.pathConnector.opacity(isComplete ? 1 : 0.2)),
          style: StrokeStyle(lineWidth: 10, lineCap: .round, dash: [15, 40])
        )
      }
    }

    var start: CGPoint { (current ?? .center(index: -1)).point(total: total) }
    var end: CGPoint { (next ?? .center(index: total)).point(total: total) }
  }
}
