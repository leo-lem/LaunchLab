//
// Copyright © 2024 Maximillian Stabe. All rights reserved.
//

import Foundation
import MessageUI
import SwiftUI

/// An Email composition view
/// 
/// Credit for this struct goes to https://swiftuirecipes.com/blog/send-mail-in-swiftui
public typealias MailViewCallback = ((Result<MFMailComposeResult, Error>) -> Void)?
public struct MailView: UIViewControllerRepresentable {
  public let email: Email,
             callback: MailViewCallback

  public init(email: Email, callback: MailViewCallback) {
    self.email = email
    self.callback = callback
  }

  public class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
    @Binding public var presentation: PresentationMode
    public var data: Email
    public let callback: MailViewCallback

    public init(
      presentation: Binding<PresentationMode>,
      data: Email,
      callback: MailViewCallback
    ) {
      _presentation = presentation
      self.data = data
      self.callback = callback
    }

    public func mailComposeController(
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

  @Environment(\.presentationMode) var presentation

  public func makeCoordinator() -> Coordinator {
    Coordinator(presentation: presentation, data: email, callback: callback)
  }

  public func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
    let mvc = MFMailComposeViewController()
    mvc.mailComposeDelegate = context.coordinator
    mvc.setSubject(email.subject)
    mvc.setToRecipients([email.address])
    mvc.setMessageBody(email.body, isHTML: false)
    if let data = email.attachmentData, let filename = email.attachmentFilename {
      mvc.addAttachmentData(data, mimeType: "application/pdf", fileName: filename)
    }

    mvc.accessibilityElementDidLoseFocus()
    return mvc
  }

  public func updateUIViewController(
    _ uiViewController: MFMailComposeViewController,
    context: UIViewControllerRepresentableContext<MailView>
  ) {}

  public static var canSend: Bool {
    MFMailComposeViewController.canSendMail()
  }
}
