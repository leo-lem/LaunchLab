//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import SwiftUI

public struct ConsultingView: View {
  private let dismissAction: () -> Void
  private let bookConsultationAction: () -> Void

  public init(dismissAction: @escaping () -> Void, bookConsultationAction: @escaping () -> Void) {
    self.dismissAction = dismissAction
    self.bookConsultationAction = bookConsultationAction
  }

  public var body: some View {
    VStack(spacing: 20) {
      Image("consultation")
        .resizable()
        .scaledToFit()

      Text("You can now book a free consultation with Transferagentur!")
        .font(.title)
        .bold()
        .multilineTextAlignment(.center)

      Text("Take this chance to refine your ideas and get expert advice. Not interested? Feel free to skip this module and continue.")
        .font(.subheadline)
        .foregroundStyle(.secondary)
        .multilineTextAlignment(.center)

      Spacer()

      ActionPrimaryButton(isClickable: true, title: "Start Consultation", action: bookConsultationAction)

      Button("Mark as completed") { dismissAction() }
        .padding(.top, -10)
    }
    .padding(.vertical, 20)
    .padding(.horizontal, 30)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button(action: dismissAction) {
          Image(systemName: "xmark.circle")
            .frame(width: 20, height: 20)
        }
      }
    }
  }
}
