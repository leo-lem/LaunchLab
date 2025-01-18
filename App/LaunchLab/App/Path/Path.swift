//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import LLExtensions
import SwiftfulRouting
import SwiftUI
import UIComponents

/// The central path element structuring the modules.
struct Path: View {
  let modules: [Module]

  var body: some View {
    ZStack {
      ForEach(modules, id: \.index) { module in
        Node(module: module, total: modules.count)
          .onTapGesture { selection = module }
          .zIndex(1)

        Connector(
          current: Path.Position(module),
          next: next(after: module).flatMap(Path.Position.init),
          isComplete: module.isCompleted,
          total: modules.count
        )
      }
    }
    .onTapGesture { selection = nil }
    .frame(maxWidth: .infinity, minHeight: CGFloat((modules.count + 1) * 150))
    .padding(.top, 50)
    .onChange(of: selection) {
      if let selection {
        router.showResizableSheet(
          sheetDetents: [.large],
          selection: .constant(.large),
          showDragIndicator: false
        ) {
          self.selection = nil
        } destination: { _ in
          detail(selection)
        }
      }
    }
  }

  @State private var selection: Module?
  @Environment(\.router) private var router

  private func next(after module: Module) -> Module? {
    modules.first { $0.index == module.index + 1 }
  }

  private func isUnlocked(_ module: Module) -> Bool {
    module.index == 0 ||
      modules.first { $0.index == module.index - 1 }?.isCompleted ?? false
  }

  @ViewBuilder private func detail(_ selected: Module) -> some View {
    switch selected.type {
    case "consultation":
      ConsultingView(
        isAvailable: isUnlocked(selected),
        isCompleted: selected.isCompleted
      ) {
        selected.progress = 1
        CoreDataStack.shared.save()
      }
    case "document":
      DocumentView(
        isAvailable: isUnlocked(selected),
        isCompleted: selected.isCompleted,
        documentTitle: selected.title
      ) {
        selected.progress = 1
        CoreDataStack.shared.save()
      }
    default:
      Module.Summary(module: selected, isUnlocked: isUnlocked(selected))
    }
  }
}

extension Module: @retroactive Identifiable {
  public var id: Int { Int(self.index) }
}

#Preview {
  ScrollView {
    Path(modules: Module.examples)
  }
  .defaultScrollAnchor(.bottom)
}
