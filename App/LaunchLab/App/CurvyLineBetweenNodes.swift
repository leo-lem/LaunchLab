//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import SwiftUI

struct CurvyLinesBetweenNodes: View {
  let moduleCompletionStatus: [Bool]
  let nodeCount: Int

  var body: some View {
    Canvas { context, _ in
      var path = Path()

      for index in 0 ..< nodeCount {
        let current = nodePosition(for: index)
        if index < nodeCount - 1 {
          let next = nodePosition(for: index + 1)

          let controlPoint1 = CGPoint(
            x: (current.x + next.x) / 2 + 100,
            y: current.y + 50
          )

          let controlPoint2 = CGPoint(
            x: (current.x + next.x) / 2 - 100,
            y: next.y - 50
          )

          if index == 4 {
            path.move(to: current)
            path.addCurve(to: next, control1: controlPoint1, control2: controlPoint2)
          }

          let isCompleted = moduleCompletionStatus[index]
          context.stroke(
            path,
            with: .color(isCompleted ? .green : .gray),
            style: StrokeStyle(lineWidth: 15, lineCap: .round, dash: [15, 40])
          )
        }
      }
    }
  }

  private func nodePosition(for index: Int) -> CGPoint {
    let xOffset = index.isMultiple(of: 2) ? 100.0 : UIScreen.main.bounds.width - 100.0
    let yOffset = CGFloat(index * 150 + 100)
    return CGPoint(x: xOffset, y: yOffset)
  }
}
