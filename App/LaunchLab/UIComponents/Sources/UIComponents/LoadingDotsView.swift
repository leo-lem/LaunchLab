//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import SwiftUI

/// An animated loading indicator.
public struct LoadingDotsView: View {
  public init() {}

  public var body: some View {
    HStack {
      Circle()
        .fill(Color.blue)
        .frame(width: 10, height: 10)
        .scaleEffect(animate ? 1.0 : 0.5)
        .animation(.easeInOut(duration: 0.5).repeatForever(), value: animate)
      Circle()
        .fill(Color.blue)
        .frame(width: 10, height: 10)
        .scaleEffect(animate ? 1.0 : 0.5)
        .animation(.easeInOut(duration: 0.5).repeatForever().delay(0.3), value: animate)
      Circle()
        .fill(Color.blue)
        .frame(width: 10, height: 10)
        .scaleEffect(animate ? 1.0 : 0.5)
        .animation(.easeInOut(duration: 0.5).repeatForever().delay(0.6), value: animate)
    }
    .onAppear {
      self.animate = true
    }
  }

  @State private var animate = false
}
