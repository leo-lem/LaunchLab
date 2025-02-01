import Data
import SwiftUI
import TipKit

extension Path {
  struct Node: View {
    let module: Module,
        total: Int

    var body: some View {
      if module.index == 0 {
        Image(module.image)
          .resizable()
          .scaledToFit()
          .frame(maxHeight: module.type == .module ? 120 : 80)
          .scaleEffect(module.type == .module ? 1 : 0.8)
          .popoverTip(ModuleTip())
          .position(position.point(total: total))
      } else {
        Image(module.image)
          .resizable()
          .scaledToFit()
          .frame(maxHeight: module.type == .module ? 120 : 80)
          .scaleEffect(module.type == .module ? 1 : 0.8)
          .position(position.point(total: total))
      }
    }

    private var position: Path.Position { Path.Position(module) }
  }
}
