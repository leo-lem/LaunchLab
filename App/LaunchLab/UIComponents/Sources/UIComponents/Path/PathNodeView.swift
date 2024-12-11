//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import SwiftUI

public struct PathNodeView: View {
  let gradient: LinearGradient
  let planetImageString: String
  let onClick: () -> Void

  public init(gradient: LinearGradient, planetImageString: String, onClick: @escaping () -> Void) {
    self.gradient = gradient
    self.planetImageString = planetImageString
    self.onClick = onClick
  }

  public var body: some View {
    Button(action: onClick) {
      RoundedRectangle(cornerRadius: 24)
        .fill(gradient)
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
