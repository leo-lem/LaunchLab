//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import Styleguide
import SwiftUI

struct HomeScreen: View {
  @Environment(\.router) private var router
  @FetchRequest(entity: Module.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Module.index, ascending: false)])
  private var modules: FetchedResults<Module>

  var body: some View {
    ZStack {
      LearningPath(modules: modules.sorted { $0.index > $1.index })
      topButton
    }
    .preferredColorScheme(.dark)
  }

  private var topButton: some View {
    VStack(alignment: .leading) {
      Text("\(modules.filter(\.isCompleted).count)/\(modules.count) completed")
        .foregroundStyle(.gray)
        .font(.subheadline)

      Text("Modules")
        .foregroundStyle(.black)
        .font(.headline)
        .bold()
    }
    .padding(.horizontal, 40)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(topTextBackground)
    .padding(.top, 20)
    .frame(maxHeight: .infinity, alignment: .top)
    .onTapGesture {
      router
        .showResizableSheet(
          sheetDetents: [.large, .medium],
          selection: .constant(.large),
          showDragIndicator: true
        ) { _ in
          MenuScreen(modules: Array(modules))
        }
    }
  }

  private var topTextBackground: some View {
    RoundedRectangle(cornerRadius: 16)
      .padding(.horizontal, 10)
      .foregroundStyle(
        LinearGradient(
          gradient: Gradient(colors: [
            Color(red: 248 / 255, green: 227 / 255, blue: 206 / 255),
            Color(red: 228 / 255, green: 183 / 255, blue: 181 / 255)
          ]),
          startPoint: .top,
          endPoint: .bottom
        )
      )
      .frame(width: UIScreen.main.bounds.width - 20, height: 75)
      .shadow(radius: 3, x: 3, y: 5)
  }
}

#Preview {
  HomeScreen()
}
