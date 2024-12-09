//
// Copyright © 2024 Maximillian Stabe. All rights reserved.
//

import Foundation
import MessageUI
import SwiftUI

// Credit for this struct goes to https://swiftuirecipes.com/blog/send-mail-in-swiftui

typealias MailViewCallback = ((Result<MFMailComposeResult, Error>) -> Void)?

struct MailView: UIViewControllerRepresentable {
  @Environment(\.presentationMode) var presentation
  let supportEmail: SupportEmail
  let callback: MailViewCallback

  class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
    @Binding var presentation: PresentationMode
    var data: SupportEmail
    let callback: MailViewCallback

    init(
      presentation: Binding<PresentationMode>,
      data: SupportEmail,
      callback: MailViewCallback
    ) {
      _presentation = presentation
      self.data = data
      self.callback = callback
    }

    func mailComposeController(
      _ controller: MFMailComposeViewController,
      didFinishWith result: MFMailComposeResult,
      error: Error?
    ) {
      if let error = error {
        callback?(.failure(error))
      } else {
        callback?(.success(result))
      }
      $presentation.wrappedValue.dismiss()
    }
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(presentation: presentation, data: supportEmail, callback: callback)
  }

  func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
    let mvc = MFMailComposeViewController()
    mvc.mailComposeDelegate = context.coordinator
    mvc.setSubject(supportEmail.subject)
    mvc.setToRecipients([supportEmail.toAdress])
    mvc.setMessageBody(supportEmail.body, isHTML: false)
    mvc.accessibilityElementDidLoseFocus()
    return mvc
  }

  func updateUIViewController(
    _ uiViewController: MFMailComposeViewController,
    context: UIViewControllerRepresentableContext<MailView>
  ) {}

  static var canSendMail: Bool {
    MFMailComposeViewController.canSendMail()
  }
}
