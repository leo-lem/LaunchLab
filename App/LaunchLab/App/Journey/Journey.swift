//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import Styleguide
import SwiftUI

/// The app's central screen, displaying the startup journey.
struct Journey: View {
  @Environment(\.router) private var router
  @FetchRequest(entity: Module.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Module.index, ascending: false)])
  private var modules: FetchedResults<Module>

  var body: some View {
    ZStack {
      LearningPath(modules: modules.sorted { $0.index > $1.index })
      Stats.Button(complete: modules.filter(\.isCompleted).count, total: modules.count)
    }
  }
}

#Preview {
  Journey()
}
