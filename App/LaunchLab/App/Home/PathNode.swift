//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import Styleguide
import SwiftfulRouting
import SwiftUI
import UIComponents

struct PathNode: View {
  @Environment(\.router) private var router
  @FetchRequest(entity: Module.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Module.index, ascending: true)])
  private var modules: FetchedResults<Module>

  @Binding var infoModalIndex: Int
  let module: Module

  var body: some View {
    ZStack {
      nodeAndPath
      balloonPopup
      trailingRocketCollectable
    }
  }

  private var nodeAndPath: some View {
    PathNodeView(gradient: module.gradient, planetImageString: module.image) {
      withAnimation {
        infoModalIndex = infoModalIndex == module.index ? -1 : Int(module.index)
      }
    }
    .position(PositionHelper.position(for: Int(module.index)))
  }

  private var balloonPopup: some View {
    Group {
      if infoModalIndex == module.index {
        BalloonPopupView(
          title: module.title,
          progress: isButtonEnabled() ? module.desc : "Locked.",
          gradient: module.gradient,
          isTriangleOnTop: module.index == 0,
          isButtonDisabled: !isButtonEnabled()
        ) {
          router.showScreen(.sheet) { _ in
            ModuleInfo(module: module)
          }

          infoModalIndex = -1
        }
        .position(PositionHelper.position(for: Int(module.index)))
        .offset(y: module.index == 0 ? 100 : -100)
        .padding(.bottom, module.index == 0 ? 100 : -100)
      }
    }
  }

  private var trailingRocketCollectable: some View {
    Group {
      if module.isCompleted {
        Image(module.collectable)
          .resizable()
          .scaledToFit()
          .frame(width: 40)
      } else {
        Text("?")
          .font(.largeTitle)
          .bold()
          .shadow(radius: 5, y: 3)
      }
    }
    .position(PositionHelper.position(for: Int(module.index), reverseX: true))
    .padding(.top, 40)
  }

  private func isButtonEnabled() -> Bool {
    module.index == 6 || modules
      .first { $0.index == module.index + 1 }?.isCompleted ?? false
  }

  enum PositionHelper {
    static func position(for index: Int, reverseX: Bool = false) -> CGPoint {
      let xOffset: CGFloat
      if reverseX {
        xOffset = index.isMultiple(of: 2) ? UIScreen.main.bounds.width - 100.0 : 100.0
      } else {
        xOffset = index.isMultiple(of: 2) ? 100.0 : UIScreen.main.bounds.width - 100.0
      }

      let yOffset = CGFloat(index * 150 + 100)
      return CGPoint(x: xOffset, y: yOffset)
    }
  }
}
