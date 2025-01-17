//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

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
      if module.index == 0 {
        self = .center(index: 0)
      } else {
        self = switch module.pathPosition {
        case "left":
            .leading(index: Int(module.index))
        case "right":
            .trailing(index: Int(module.index))
        case "center":
            .center(index: Int(module.index))
        default:
            .center(index: Int(module.index))
        }
      }
    }
  }
}
