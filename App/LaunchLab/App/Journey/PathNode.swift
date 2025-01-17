//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import MessageUI
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

  private var isPreviousModuleCompleted: Bool {
    modules[safe: Int(module.index - 1)]?.isCompleted ?? false
  }

  private var isFirstOrPreviousModuleCompleted: Bool {
    module.index == 0 || isPreviousModuleCompleted
  }

  var body: some View {
    ZStack {
      nodeAndPath
      trailingRocketCollectable
    }
  }

  private var nodeAndPath: some View {
    PathNodeView(
      gradient: module.gradient,
      isRocketImage: module.type == "module",
      imageString: module.image
    ) {
      handleModuleType()
    }
    .position(PositionHelper.position(for: module.pathPosition, index: module.index, moduleCount: modules.count))
  }

  private var trailingRocketCollectable: some View {
    Group {
      if let collectable = module.collectable {
        if module.isCompleted {
          Image(collectable)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: 40, maxHeight: 100)
        } else {
          Text("?")
            .font(.largeTitle)
            .bold()
            .shadow(radius: 5, y: 3)
            .frame(maxWidth: 40, maxHeight: 100)
        }
      }
    }
    .position(PositionHelper.position(for: module.pathPosition, reverseX: true, index: module.index, moduleCount: modules.count))
  }

  private func handleModuleType() {
    switch module.type {
    case "consultation":
      showConsultationScreen()
    case "document":
      showDocumentScreen()
    default:
      showModuleInfoScreen()
    }
  }

  private func showConsultationScreen() {
    router.showScreen(.sheet) { subrouter in
      ConsultingView(
        isAvailable: isPreviousModuleCompleted,
        isCompleted: module.isCompleted
      ) {
        module.progress = 10
        subrouter.dismissScreen()
        CoreDataStack.shared.save()
      } bookConsultationAction: {
        handleBookConsultationAction(subrouter: subrouter)
      }
    }
  }

  private func showDocumentScreen() {
    router.showScreen(.sheet) { subrouter in
      DocumentView(
        isAvailable: isPreviousModuleCompleted || module.index == 0,
        isCompleted: module.isCompleted,
        documentTitle: module.title
      ) {
        module.progress = 10
        subrouter.dismissScreen()
        CoreDataStack.shared.save()
      }
    }
  }

  private func handleBookConsultationAction(subrouter: AnyRouter) {
    if MailView.canSend {
      subrouter.showScreen(.sheet) { subrouter in
        MailView(email: .consultation) { result in
          handleMailResult(result, subrouter: subrouter)
        }
      }
    } else {
      showMailUnavailableAlert(subrouter: subrouter)
    }
  }

  private func handleMailResult(_ result: Result<MFMailComposeResult, Error>, subrouter: AnyRouter) {
    switch result {
    case .success:
      module.progress = 10
      subrouter.dismissScreen()
      CoreDataStack.shared.save()
    case .failure(let error):
      print(error.localizedDescription)
    }
  }

  private func showMailUnavailableAlert(subrouter: AnyRouter) {
    subrouter.showAlert(
      .alert,
      title: L10n.errorOccured,
      subtitle: L10n.mailAlertSubtitle,
      alert: {}
    )
  }

  private func showModuleInfoScreen() {
    router.showScreen(.sheet) { _ in
      ModuleInfo(
        module: module,
        isAvailable: isFirstOrPreviousModuleCompleted
      )
    }
  }

  private func isButtonEnabled() -> Bool {
    module.index == 6 || modules
      .first { $0.index == module.index + 1 }?.isCompleted ?? false
  }

  enum PositionHelper {
    static func position(for modulePosition: String, reverseX: Bool = false, index: Int16, moduleCount: Int) -> CGPoint {
      let xOffset: CGFloat

      switch modulePosition {
      case "left":
        xOffset = reverseX ? 100.0 : UIScreen.main.bounds.width - 100.0
      case "right":
        xOffset = reverseX ? UIScreen.main.bounds.width - 100.0 : 100.0
      default:
        xOffset = UIScreen.main.bounds.width / 2
      }

      let yOffset = CGFloat(Int(index) * -150 + moduleCount * 150)
      return CGPoint(x: xOffset, y: yOffset)
    }
  }
}
