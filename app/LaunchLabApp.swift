//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import SwiftUIComponents
import TipKit

/// The entrypoint of the app, with the CoreData context and a router in the environment.
@main
struct LaunchLabApp: App {
  var body: some Scene {
    WindowGroup {
      Journey()
        .modelContainer(for: Module.self, onSetup: Module.setup)
    }
  }

  init() { try? Tips.configure() }
}

struct CoFounderTip: Tip {
  var title = Text(L10n.cofounderTipTitle)
  var message: Text? = Text(L10n.cofounderTipMessage)
}

struct ModuleTip: Tip {
  var title = Text(L10n.moduleTipTitle)
  var message: Text? = Text(L10n.moduleTipMessage)
}
