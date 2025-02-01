import Data
import SwiftUIComponents

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
    .sheet(item: $selection) { Summary(module: $0, isUnlocked: isUnlocked($0)) }
  }

  @State private var selection: Module?

  /// Fetch the next module by index.
  private func next(after module: Module) -> Module? {
    modules.first { $0.index == module.index + 1 }
  }

  /// Checks whether a given module is unlocked by being first or the previous one having been completed.
  private func isUnlocked(_ module: Module) -> Bool {
    module.index == 0 ||
      modules.first { $0.index == module.index - 1 }?.isCompleted ?? false
  }
}
