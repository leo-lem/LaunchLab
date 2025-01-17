//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import LLExtensions
import SwiftfulRouting
import SwiftUI
import UIComponents

struct Path: View {
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
          ForEach(Array(modules.enumerated()), id: \.offset) { index, module in
            Node(selection: $selection, module: module, total: modules.count)
              .sheet(item: $selection) { selected in
                switch selected.type {
                case "consultation":
                  ConsultingView(
                    isAvailable: isUnlocked(selected),
                    isCompleted: module.isCompleted
                  ) {
                    module.progress = 10
                    CoreDataStack.shared.save()
                  } bookConsultationAction: {
                  }
                case "document":
                  DocumentView(
                    isAvailable: isUnlocked(selected),
                    isCompleted: module.isCompleted,
                    documentTitle: module.title
                  ) {
                    module.progress = 10
                    CoreDataStack.shared.save()
                  }
                default:
                  ModuleInfo(
                    module: module,
                    isAvailable: isUnlocked(selected)
                  )
                }
              }

            Connector(
              current: Path.Position(module),
              next: modules[safe: index + 1].flatMap(Path.Position.init) ?? .center(index: modules.count),
              isComplete: module.isCompleted,
              total: modules.count
            )
            .onTapGesture { selection = nil }
            .zIndex(-1)
          }
        }
        .frame(maxWidth: .infinity, minHeight: CGFloat(modules.count * 150))
        .padding(.top, 50)

        Image(.start)
          .resizable()
          .scaledToFit()
          .padding(.top, -50)
          .padding(.bottom, -250)
      }
    }
    .background(LinearGradient(
      gradient: Gradient(colors: [
        Color(red: 7 / 255, green: 16 / 255, blue: 46 / 255),
        Color(red: 66 / 255, green: 126 / 255, blue: 134 / 255)
      ]),
      startPoint: .top,
      endPoint: .bottom
    )
    .ignoresSafeArea(.all)
    .padding(.vertical, -300))
    .defaultScrollAnchor(.bottom)
  }

  @State private var selection: Module?
  @Environment(\.router) private var router

  private func isUnlocked(_ module: Module) -> Bool {
    module.index == 0 || modules[safe: Int(module.index - 1)]?.isCompleted ?? false
  }
}

extension Module: @retroactive Identifiable {
  public var id: Int { Int(self.index) }
}

public extension Collection {
  subscript(safe index: Index) -> Element? {
    indices.contains(index) ? self[index] : nil
  }
}

#Preview {
  Path(modules: Module.examples)
}
