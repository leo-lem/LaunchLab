//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Styleguide
import SwiftfulRouting
import SwiftUI
import UIComponents

struct OnboardingWelcomeView: View {
  @Binding var showOnboarding: Bool

  var body: some View {
    RouterView { router in
      VStack {
        welcomeImage
        welcomeText
        Spacer()
        startButton(router)
      }
      .padding(24)
      .background(
        LinearGradient(
          gradient: Gradient(colors: [
            Color(red: 248/255, green: 227/255, blue: 206/255),
            Color(red: 228/255, green: 183/255, blue: 181/255)
          ]),
          startPoint: .top,
          endPoint: .bottom
        )
      )
    }
  }

  private var welcomeImage: some View {
    Image(.welcome)
      .resizable()
      .scaledToFit()
      .padding(.bottom, 32)
  }

  private var welcomeText: some View {
    VStack(spacing: 8) {
      Text(L10n.launchScreenTitle)
        .foregroundStyle(.black)
        .font(.title2)
        .bold()
        .padding(.horizontal, 24)

      Text(L10n.launchScreenSubtitle)
        .foregroundStyle(.black)
        .font(.subheadline)
        .padding(.horizontal, 32)
    }
    .multilineTextAlignment(.center)
    .padding(.bottom, 16)
  }

  private func startButton(_ router: AnyRouter) -> some View {
    ActionPrimaryButton(isClickable: true, title: L10n.commonStart) {
      router.showScreen(.push) { router in
        OnboardingPageView(showOnboarding: $showOnboarding, onboardingPage: .motivation, router: router)
      }
    }
  }
}
