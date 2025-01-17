//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import LLExtensions
import SwiftfulRouting
import SwiftUI

struct LearningPath: View {
  @State private var infoModalIndex = -1
  let modules: [Module]

  var body: some View {
    ScrollView(showsIndicators: false) {
      VStack(spacing: 100) {
        Image(.finalRocket)
          .resizable()
          .scaledToFit()
          .frame(width: 150)
          .padding(.top, 150)
          .padding(.bottom, -150)

        ZStack {
          ForEach(Array(self.modules.enumerated()), id: \.offset) { index, module in
            PathNode(infoModalIndex: self.$infoModalIndex, module: module)

            PathConnector(module: module, nextModulePosition: modules[safe: index - 1]?.pathPosition ?? "center", total: self.modules.count)
              .onTapGesture { self.infoModalIndex = -1 }
              .zIndex(-1)
          }
        }
        .frame(maxWidth: .infinity, minHeight: CGFloat(self.modules.count * 150))
        .padding(.top, 50)

        Image(.start)
          .resizable()
          .scaledToFit()
          .padding(.top, -50)
          .padding(.bottom, -250)
      }
    }
    .background(content: backgroundGradient)
    .defaultScrollAnchor(.bottom)
  }

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

public extension Collection {
  subscript(safe index: Index) -> Element? {
    indices.contains(index) ? self[index] : nil
  }
}

#Preview {
  LearningPath(modules: Module.examples)
}
