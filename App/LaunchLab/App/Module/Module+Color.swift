//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import SwiftUI

extension Module {
  var gradient: LinearGradient {
    LinearGradient(
      gradient: Gradient(colors: [colors.start, colors.end]),
      startPoint: .topLeading,
      endPoint: .bottomTrailing
    )
  }

  private var colors: (start: Color, end: Color) {
    switch index {
    case 0:
      (.blue, .purple)
    case 1:
      (.orange, .pink)
    case 2:
      (.red, .pink)
    case 3:
      (.green, .yellow)
    case 4:
      (.teal, .cyan)
    case 5:
      (.red, .orange)
    case 6:
      (.indigo, .mint)
    default:
      (.pink, .purple)
    }
  }
}
