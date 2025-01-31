//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import CoFounder
import Data
import SwiftUI

/// The app's central screen, displaying the startup journey.
struct Journey: View {
  var body: some View {
    ScrollView(showsIndicators: false) {
      Rocket(isUnlocked: modules.allSatisfy(\.isCompleted))
        .padding()
        .padding(.top, 100)

      Path(modules: modules)

      Image(.earth)
        .resizable()
        .scaledToFit()
        .saturation(0.3)
        .padding(.top, -50)
        .padding(.bottom, -250)
    }
    .defaultScrollAnchor(.bottom)
    .background(
      LinearGradient(colors: [Color(.background3), Color(.background4)], startPoint: .top, endPoint: .bottom)
        .ignoresSafeArea()
    )
    .overlay {
      Stats.Overview(complete: modules.filter(\.isCompleted).count, total: modules.count)
    }
    .environmentObject(CoFounder(context))
  }

  @Query private var modules: [Module]
  @Environment(\.modelContext) private var context
}

#Preview {
  Journey()
}
