//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import Styleguide
import SwiftfulRouting
import SwiftUI
import UIComponents

struct NodeWithAction: View {
  @FetchRequest(
    entity: Module.entity(),
    sortDescriptors: [NSSortDescriptor(keyPath: \Module.pathIndex, ascending: true)]
  )
  var modules: FetchedResults<Module>
  @Binding var infoModalIndex: Int

  let module: Module
  let index: Int
  let router: AnyRouter

  var body: some View {
    ZStack {
      nodeAndPath
      balloonPopup
      trailingRocketCollectable
    }
  }

  private var nodeAndPath: some View {
    PathNodeView(
      gradientStartColor: getColorForModule(module).0,
      gradientEndColor: getColorForModule(module).1,
      planetImageString: module.planetImageString
    ) {
      withAnimation {
        infoModalIndex = infoModalIndex == module.pathIndex ? -1 : Int(module.pathIndex)
      }
    }
    .position(NodePositionHelper.position(for: index))
  }

  private var balloonPopup: some View {
    Group {
      if infoModalIndex == module.pathIndex {
        BalloonPopupView(
          title: module.moduleName,
          progress: isButtonEnabled() ? module.moduleDescription : "To start this Module, complete all previous modules.",
          isTriangleOnTop: module.pathIndex == 0,
          isButtonDisabled: !isButtonEnabled()
        ) {
          router.showScreen(.sheet) { router in
            ModuleInfoScreen(
              title: module.moduleName,
              subtitle: module.moduleDescription
            ) {
              VStack {
                ForEach(module.pageContent, id: \.title) { content in
                  ModuleInfoRow(
                    title: content.title,
                    subtitle: content.infoText,
                    image: Image(systemName: content.imageName)
                  )
                  .padding(.bottom, 20)
                }
              }
            } startAction: {
              module.isCompleted = true

              CoreDataStack.shared.save()
              router.dismissScreen()
            }
          }

          infoModalIndex = -1
        }
        .position(NodePositionHelper.position(for: index))
        .offset(y: module.pathIndex == 0 ? 100 : -100)
        .padding(.bottom, module.pathIndex == 0 ? 100 : -100)
      }
    }
  }

  private var trailingRocketCollectable: some View {
    Group {
      if module.isCompleted {
        Image(module.collectableImageString)
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
    .position(NodePositionHelper.position(for: index, reverseX: true))
    .padding(.top, 40)
  }

  private func isButtonEnabled() -> Bool {
    module.pathIndex == 0 || modules
      .first { $0.pathIndex == module.pathIndex - 1 }?.isCompleted ?? false
  }

  private func getColorForModule(_ module: Module) -> (Color, Color) {
    switch module.pathIndex {
    case 0:
      (.blue, .purple)
    case 1:
      (.orange, .pink)
    case 2:
      (.red, .pink)
    case 3:
      (.green, .yellow)
    case 4:
      (.teal, .cyan)
    case 5:
      (.red, .orange)
    case 6:
      (.indigo, .mint)
    default:
      (.pink, .purple)
    }
  }
}
