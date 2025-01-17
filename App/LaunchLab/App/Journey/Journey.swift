//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import Styleguide
import SwiftUI

/// The app's central screen, displaying the startup journey.
struct Journey: View {
  var body: some View {
    ZStack {
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
            .padding(.top, -50)
            .padding(.bottom, -250)
        }
      }
      .background(LinearGradient(
        gradient: Gradient(colors: [
          Color(red: 7 / 255, green: 16 / 255, blue: 46 / 255),
          Color(red: 66 / 255, green: 126 / 255, blue: 134 / 255)
        ]),
        startPoint: .top,
        endPoint: .bottom
      )
      .ignoresSafeArea(.all)
      .padding(.vertical, -300))
      .defaultScrollAnchor(.bottom)

      Stats.Button(complete: modules.filter(\.isCompleted).count, total: modules.count)
    }
  }

  @FetchRequest(entity: Module.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Module.index, ascending: false)])
  private var modules: FetchedResults<Module>
}

#Preview {
  Journey()
}
