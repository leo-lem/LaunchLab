//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Foundation
import UIKit

enum NodePositionHelper {
  static func position(for index: Int, reverseX: Bool = false) -> CGPoint {
    let xOffset: CGFloat
    if reverseX {
      xOffset = index.isMultiple(of: 2) ? UIScreen.main.bounds.width - 100.0 : 100.0
    } else {
      xOffset = index.isMultiple(of: 2) ? 100.0 : UIScreen.main.bounds.width - 100.0
    }

    let yOffset = CGFloat(index * 150 + 100)
    return CGPoint(x: xOffset, y: yOffset)
  }
}
