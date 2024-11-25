//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import SwiftUI

@main
struct LaunchLabApp: App {
  var body: some Scene {
    WindowGroup {
      HomeScreen()
        .preferredColorScheme(.dark)
    }
  }
}
