//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import Styleguide
import SwiftUI

/// The app's central screen, displaying the startup journey.
struct Journey: View {
  var body: some View {
    ScrollView(showsIndicators: false) {
      VStack(spacing: 100) {
        Image(.finalRocket)
          .resizable()
          .scaledToFit()
          .frame(width: 150)
          .padding(.top, 150)
          .padding(.bottom, -150)

        Path(modules: modules.sorted { $0.index > $1.index })

        Image(.start)
          .resizable()
          .scaledToFit()
          .padding(.top, -100)
          .padding(.bottom, -250)
      }
    }
    .background(
      LinearGradient(
        colors: [Color(hex: "07102E"), Color(hex: "427E86")],
        startPoint: .top,
        endPoint: .bottom
      )
      .ignoresSafeArea(.all))
    .defaultScrollAnchor(.bottom)
    .overlay {
      Stats.Overview(complete: modules.filter(\.isCompleted).count, total: modules.count)
    }
  }

  @FetchRequest(entity: Module.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Module.index, ascending: false)])
  private var modules: FetchedResults<Module>
}

#Preview {
  Journey()
}
