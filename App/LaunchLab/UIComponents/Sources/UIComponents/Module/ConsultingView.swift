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

  public init(isAvailable: Bool, isCompleted: Bool, dismissAction: @escaping () -> Void) {
    self.isAvailable = isAvailable
    self.isCompleted = isCompleted
    self.dismissAction = dismissAction
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

      ActionPrimaryButton(
        isClickable: true,
        title: isAvailable ? L10n.startConsulting : L10n.locked,
        action: book
      )
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
  @Environment(\.router) private var router

  private func book() {
    if MailView.canSend {
      router.showScreen(.sheet) { subrouter in
        MailView(email: .consultation) { result in
          switch result {
          case .success:
            dismissAction()
            subrouter.dismissScreen()
          case .failure(let error):
            print(error.localizedDescription)
          }
        }
      }
    } else {
      router.showAlert(
        .alert,
        title: L10n.errorOccured,
        subtitle: L10n.mailAlertSubtitle,
        alert: {}
      )
    }
  }
}
