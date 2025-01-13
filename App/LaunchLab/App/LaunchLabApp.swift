//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import SwiftfulRouting
import SwiftUI
import UIComponents

@main
struct LaunchLabApp: App {
  private let requester = ChatGPTRequester()
  @AppStorage("showOnboarding") private var onboarding = true
  @State private var chatting = false

  var body: some Scene {
    WindowGroup {
      RouterView { router in
        HomeScreen()
          .overlay(alignment: .bottomTrailing) { FloatingChatButton { chatting = true } }
          .fullScreenCover(isPresented: $onboarding) { OnboardingWelcomeView(showOnboarding: $onboarding) }
          // .sheet(isPresented: $chatting) { ChatView(send: requester.sendMessage) }
          .environment(\.router, router)
          .environment(\.managedObjectContext, CoreDataStack.shared.mainContext)
          .preferredColorScheme(.dark)
      }
    }
  }

  init() {
    CoreDataStack.shared.populateModulesIfNeeded()
  }
}
