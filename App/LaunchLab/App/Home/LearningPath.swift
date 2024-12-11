//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import LLExtensions
import SwiftfulRouting
import SwiftUI

struct LearningPath: View {
  let modules: [Module]

  var body: some View {
    ScrollView(showsIndicators: false) {
      ZStack {
        ForEach(modules, id: \.index) { module in
          PathNode(infoModalIndex: $infoModalIndex, module: module)

          if module.index < modules.count-1 {
            PathConnector(module: module, total: modules.count)
              .onTapGesture { infoModalIndex = -1 }
              .zIndex(-1)
          }
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
    .background(content: backgroundGradient)
  }

  @State private var infoModalIndex = -1

  private func backgroundGradient() -> some View {
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
}

#Preview {
  LearningPath(modules: Module.examples)
}
