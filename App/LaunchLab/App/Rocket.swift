//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import SwiftUI

/// The rocket with launch animation.
struct Rocket: View {
  let isUnlocked: Bool

  var body: some View {
    ZStack {
      if isStarting {
          Image(.scaffold)
            .resizable()
            .scaledToFit()
            .rotationEffect(.degrees(angle), anchor: .bottomLeading)
            .padding(.leading, -115)

          Image(.rocketLaunched)
            .resizable()
            .scaledToFit()
            .offset(x: 0, y: -position)
      } else {
        Image(.rocket)
          .resizable()
          .scaledToFit()
          .overlay(alignment: .bottomTrailing) {
            Button(action: launch) {
              Image(.launch)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 200)
            }
            .padding(.bottom, -100)
            .opacity(isUnlocked ? 1 : 0.2)
          }
      }
    }
  }

  @State private var position: CGFloat = 0
  @State private var angle: CGFloat = 0
  @State private var isStarting = false

  private func launch() {
    isStarting = isUnlocked

    withAnimation(.easeIn(duration: 4)) {
      position = 5_000
    }

    withAnimation(.easeIn(duration: 2)) {
      angle = -90
    }
  }
}

#Preview {
  Rocket(isUnlocked: true)
  Rocket(isUnlocked: false)
}
