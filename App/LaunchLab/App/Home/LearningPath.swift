//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import LLExtensions
import SwiftfulRouting
import SwiftUI

public extension Collection {
  subscript(safe index: Index) -> Element? {
    indices.contains(index) ? self[index] : nil
  }
}

struct LearningPath: View {
  @State private var infoModalIndex = -1
  let modules: [Module]

  var body: some View {
    ScrollView(showsIndicators: false) {
      VStack {
        Image(.finalRocket)
          .resizable()
          .scaledToFit()
          .frame(width: 150)
          .padding(.top, 150)

        ZStack {
          ForEach(Array(self.modules.enumerated()), id: \.offset) { index, module in
            PathNode(infoModalIndex: self.$infoModalIndex, module: module)

            if let module = modules[safe: index + 1] {
              PathConnector(module: module, modules: modules, total: self.modules.count)
                .onTapGesture { self.infoModalIndex = -1 }
                .zIndex(-1)
            }
          }
        }
        .frame(maxWidth: .infinity, minHeight: CGFloat(self.modules.count * 150 + 100))
        .padding(.top, 50)
      }
    }
    .background(content: self.backgroundGradient)
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

#Preview {
  LearningPath(modules: Module.examples)
}
