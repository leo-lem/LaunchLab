//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import LLExtensions
import SwiftfulRouting
import SwiftUI

struct LearningPath: View {
  @State private var infoModalIndex = -1
  let modules: FetchedResults<Module>
  let router: AnyRouter

  var body: some View {
    ScrollView(showsIndicators: false) {
      ZStack {
        backgroundGradient

        ForEach(Array(modules.enumerated()), id: \.offset) { index, module in
          drawLineToNode(isCompleted: module.isCompleted, index: index)
            .onTapGesture {
              infoModalIndex = -1 // hides infoModal on tap on background
            }
        }

        ForEach(Array(modules.enumerated()), id: \.offset) { index, module in
          NodeWithAction(
            infoModalIndex: $infoModalIndex,
            module: module,
            index: index,
            router: router
          )
        }

        Image(.finalRocket)
          .resizable()
          .scaledToFit()
          .frame(width: 150)
          .padding(.top, CGFloat(modules.count * 150 + 50))
      }
      .frame(maxWidth: .infinity, minHeight: CGFloat(modules.count * 150 + 400))
      .padding(.top, 50)
    }
  }

  private var backgroundGradient: some View {
    LinearGradient(
      gradient: Gradient(colors: [
        Color(red: 7 / 255, green: 16 / 255, blue: 46 / 255),
        Color(red: 66 / 255, green: 126 / 255, blue: 134 / 255)
      ]),
      startPoint: .top,
      endPoint: .bottom
    )
    .ignoresSafeArea(.all)
    .padding(.vertical, -300)
  }

  private func drawLineToNode(isCompleted: Bool, index: Int) -> some View {
    Canvas { context, _ in
      var path = Path()
      let current = NodePositionHelper.position(for: index)

      if index < modules.count - 1 {
        let next = NodePositionHelper.position(for: index + 1)

        let controlPoint1 = CGPoint(
          x: (current.x + next.x) / 2 + 100,
          y: current.y + 50
        )

        let controlPoint2 = CGPoint(
          x: (current.x + next.x) / 2 - 100,
          y: next.y - 50
        )

        path.move(to: current)
        path.addCurve(to: next, control1: controlPoint1, control2: controlPoint2)

        context.stroke(
          path,
          with: .color(Color(hex: "#A0E2EA").opacity(isCompleted ? 1 : 0.2)),
          style: StrokeStyle(lineWidth: 15, lineCap: .round, dash: [15, 40])
        )
      }
    }
  }
}
