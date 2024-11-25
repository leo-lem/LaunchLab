//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Styleguide
import SwiftfulRouting
import SwiftUI
import UIComponents

struct HomeScreen: View {
  @State private var showOnboarding = true

  var body: some View {
    RouterView { _ in
      VStack {
        Image(systemName: "globe")
          .imageScale(.large)
          .foregroundStyle(.tint)
      }
      .preferredColorScheme(.dark)
      .fullScreenCover(isPresented: $showOnboarding) {
        OnboardingWelcomeView(showOnboarding: $showOnboarding)
      }
    }
  }
}
