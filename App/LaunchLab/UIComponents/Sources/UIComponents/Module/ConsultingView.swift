//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Styleguide
import SwiftfulRouting
import SwiftUI

public struct ConsultingView: View {
  private let isAvailable: Bool
  private let isCompleted: Bool
  private let dismissAction: () -> Void
  private let bookConsultationAction: () -> Void

  public init(isAvailable: Bool, isCompleted: Bool, dismissAction: @escaping () -> Void, bookConsultationAction: @escaping () -> Void) {
    self.isAvailable = isAvailable
    self.isCompleted = isCompleted
    self.dismissAction = dismissAction
    self.bookConsultationAction = bookConsultationAction
  }

  public var body: some View {
    VStack(spacing: 20) {
      Image("consultation")
        .resizable()
        .scaledToFit()

      Text(L10n.consultingTitle)
        .font(.title2)
        .bold()
        .multilineTextAlignment(.center)

      Text(L10n.consultingSubtitle)
        .font(.subheadline)
        .foregroundStyle(.secondary)
        .multilineTextAlignment(.center)

      Spacer()

      ActionPrimaryButton(isClickable: true, title: isAvailable ? L10n.startConsulting : L10n.locked, action: bookConsultationAction)
        .disabled(!isAvailable)

      if isAvailable && !isCompleted {
        Button(L10n.markCompleted) { dismissAction() }
          .padding(.top, -10)
      }
    }
    .padding(.vertical, 20)
    .padding(.horizontal, 30)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button(action: dismiss.callAsFunction) {
          Image(systemName: "xmark.circle")
            .frame(width: 20, height: 20)
        }
      }
    }
  }

  @Environment(\.dismiss) private var dismiss
}

//private func handleBookConsultationAction(subrouter: AnyRouter) {
//  if MailView.canSend {
//    subrouter.showScreen(.sheet) { subrouter in
//      MailView(email: .consultation) { result in
//        handleMailResult(result, subrouter: subrouter)
//      }
//    }
//  } else {
//    showMailUnavailableAlert(subrouter: subrouter)
//  }
//}
//
//private func handleMailResult(_ result: Result<MFMailComposeResult, Error>, subrouter: AnyRouter) {
//  switch result {
//  case .success:
//    module.progress = 10
//    subrouter.dismissScreen()
//    CoreDataStack.shared.save()
//  case .failure(let error):
//    print(error.localizedDescription)
//  }
//}
//
//private func showMailUnavailableAlert(subrouter: AnyRouter) {
//  subrouter.showAlert(
//    .alert,
//    title: L10n.errorOccured,
//    subtitle: L10n.mailAlertSubtitle,
//    alert: {}
//  )
//}
