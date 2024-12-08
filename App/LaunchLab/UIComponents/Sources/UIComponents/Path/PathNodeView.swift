//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import SwiftUI

public struct PathNodeView: View {
  private let gradientStartColor: Color
  private let gradientEndColor: Color
  private let planetImageString: String
  private let onClick: () -> Void

  public init(gradientStartColor: Color, gradientEndColor: Color, planetImageString: String, onClick: @escaping () -> Void) {
    self.gradientStartColor = gradientStartColor
    self.gradientEndColor = gradientEndColor
    self.planetImageString = planetImageString
    self.onClick = onClick
  }

  public var body: some View {
    Button(action: onClick) {
      RoundedRectangle(cornerRadius: 24)
        .fill(
          LinearGradient(
            gradient: Gradient(
              colors: [
                gradientStartColor,
                gradientEndColor
              ]
            ),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
          )
        )
        .frame(width: 100, height: 100)
        .overlay {
          Image(planetImageString)
            .resizable()
            .scaledToFit()
            .frame(width: 100)
        }
    }
  }
}
