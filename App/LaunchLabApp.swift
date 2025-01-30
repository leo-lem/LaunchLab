//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import SwiftfulRouting
import SwiftUI
import TipKit
import UIComponents

/// The entrypoint of the app, with the CoreData context and a router in the environment.
@main
struct LaunchLabApp: App {
  init() {
    try? Tips.configure()
    CoreDataStack.shared.populateModulesIfNeeded()
  }

  var body: some Scene {
    WindowGroup {
      RouterView { router in
        Journey()
          .environment(\.router, router)
          .environment(\.managedObjectContext, CoreDataStack.shared.mainContext)
      }
    }
  }
}
