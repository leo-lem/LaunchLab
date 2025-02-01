import Data
import UIKit

extension Path {
  enum Position {
    case leading(index: Int),
         center(index: Int),
         trailing(index: Int)

    func point(total: Int) -> CGPoint {
      switch self {
      case let .leading(index):
        return CGPoint(x: 100.0, y: CGFloat(total-index) * 150)
      case let .trailing(index):
        return CGPoint(x: UIScreen.main.bounds.width - 100.0, y: CGFloat(total-index) * 150)
      case let .center(index):
        return CGPoint(x: UIScreen.main.bounds.width / 2, y: CGFloat(total-index) * 150)
      }
    }

    var opposite: Position {
      switch self {
      case let .leading(index):
        .trailing(index: index)
      case let .trailing(index):
        .leading(index: index)
      case let .center(index):
        .center(index: index)
      }
    }

    init(_ module: Module) {
      self = switch module.position {
      case .leading:
          .leading(index: Int(module.index))
      case .trailing:
          .trailing(index: Int(module.index))
      default:
          .center(index: Int(module.index))
      }
    }
  }
}
