//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import SwiftfulRouting
import SwiftUI

public struct ConsultingView: View {
  @Environment(\.router) var router
  private let isAvailable: Bool
  private let dismissAction: () -> Void
  private let bookConsultationAction: () -> Void

  public init(isAvailable: Bool, dismissAction: @escaping () -> Void, bookConsultationAction: @escaping () -> Void) {
    self.isAvailable = isAvailable
    self.dismissAction = dismissAction
    self.bookConsultationAction = bookConsultationAction
  }

  public var body: some View {
    VStack(spacing: 20) {
      Image("consultation")
        .resizable()
        .scaledToFit()

      Text("You can now book a free consultation with Transferagentur!")
        .font(.title2)
        .bold()
        .multilineTextAlignment(.center)

      Text("Take this chance to refine your ideas and get expert advice. Not interested? Feel free to skip this module and continue.")
        .font(.subheadline)
        .foregroundStyle(.secondary)
        .multilineTextAlignment(.center)

      Spacer()

      ActionPrimaryButton(isClickable: true, title: isAvailable ? "Start Consultation" : "Locked 🔒", action: bookConsultationAction)
        .disabled(!isAvailable)

      if isAvailable {
        Button("Mark as completed") { dismissAction() }
          .padding(.top, -10)
      }
    }
    .padding(.vertical, 20)
    .padding(.horizontal, 30)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button(action: router.dismissScreen) {
          Image(systemName: "xmark.circle")
            .frame(width: 20, height: 20)
        }
      }
    }
  }
}
