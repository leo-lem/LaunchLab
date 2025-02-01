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
    let allColors = [Color.blue, .green, .yellow, .orange, .red, .purple, .pink, .teal, .brown, .cyan, .indigo, .mint]

    return (allColors[Int(index) % allColors.count], allColors[Int(index + 1) % allColors.count])
  }
}
