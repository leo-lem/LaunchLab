//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import SwiftUI
import UIComponents

@main
struct LaunchLabApp: App {
  init() {
    CoreDataStack.shared.populateModulesIfNeeded()
  }

  private let requester = ChatGPTRequester()
  @State private var chatting = false

  var body: some Scene {
    WindowGroup {
      HomeScreen()
        .overlay(alignment: .bottomTrailing) { FloatingChatButton { chatting = true }}
        .sheet(isPresented: $chatting) { ChatView(send: requester.sendMessage) }
        .preferredColorScheme(.dark)
        .environment(\.managedObjectContext, CoreDataStack.shared.mainContext)
    }
  }
}
