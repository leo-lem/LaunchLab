//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import SwiftUI

public struct PathNodeView: View {
  let gradient: LinearGradient
  let imageString: String
  let isRocketImage: Bool
  let onClick: () -> Void

  public init(gradient: LinearGradient, isRocketImage: Bool, imageString: String, onClick: @escaping () -> Void) {
    self.gradient = gradient
    self.isRocketImage = isRocketImage
    self.imageString = imageString
    self.onClick = onClick
  }

  public var body: some View {
    Button(action: onClick) {
      Image(imageString)
        .resizable()
        .scaledToFit()
        .frame(maxHeight: isRocketImage ? 120 : 80)
        .scaleEffect(isRocketImage ? 1 : 0.8)
        .ifModifier(!isRocketImage) { $0.padding(-5) }
    }
  }
}
