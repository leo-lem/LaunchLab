//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//
// swiftlint: disable let_var_whitespace

import Data
import Styleguide
import SwiftfulRouting
import SwiftUI

struct HomeScreen: View {
  @AppStorage("showOnboarding") private var showOnboarding = true

  @FetchRequest(
    entity: Module.entity(),
    sortDescriptors: [NSSortDescriptor(keyPath: \Module.pathIndex, ascending: true)]
  ) var modules: FetchedResults<Module>

  var body: some View {
    RouterView { router in
      ZStack {
        LearningPath(modules: modules, router: router)
        topButton(router)
      }
      .preferredColorScheme(.dark)
      .fullScreenCover(isPresented: $showOnboarding) {
        OnboardingWelcomeView(showOnboarding: $showOnboarding)
      }
    }
  }

  private func topButton(_ router: AnyRouter) -> some View {
    VStack(alignment: .leading) {
      Text(getModuleCompletedText())
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
      .frame(width: 400, height: 75)
      .shadow(radius: 3, x: 3, y: 5)
  }

  private func getModuleCompletedText() -> String {
    let totalModules = modules.count
    let completedModules = modules.filter { $0.isCompleted }.count

    return "\(completedModules)/\(totalModules) completed"
  }
}
