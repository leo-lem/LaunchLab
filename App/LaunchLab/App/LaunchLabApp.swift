//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import SwiftUI

@main
struct LaunchLabApp: App {
  init() {
    CoreDataStack.shared.populateModulesIfNeeded()
  }

  var body: some Scene {
    WindowGroup {
      HomeScreen()
        .preferredColorScheme(.dark)
        .environment(\.managedObjectContext, CoreDataStack.shared.mainContext)
    }
  }
}
