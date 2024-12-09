//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import SwiftUI

public struct LoadingDotsView: View {
  @State private var shouldAnimate = false

  public init() {}

  public var body: some View {
    HStack {
      Circle()
        .fill(Color.blue)
        .frame(width: 10, height: 10)
        .scaleEffect(shouldAnimate ? 1.0 : 0.5)
        .animation(Animation.easeInOut(duration: 0.5).repeatForever())
      Circle()
        .fill(Color.blue)
        .frame(width: 10, height: 10)
        .scaleEffect(shouldAnimate ? 1.0 : 0.5)
        .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.3))
      Circle()
        .fill(Color.blue)
        .frame(width: 10, height: 10)
        .scaleEffect(shouldAnimate ? 1.0 : 0.5)
        .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.6))
    }
    .onAppear {
      self.shouldAnimate = true
    }
  }
}
