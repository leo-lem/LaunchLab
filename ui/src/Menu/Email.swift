//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import MessageUI
import UIKit

/// An email wrapper to open a Mail view with.
public struct Email: Identifiable {
  public var id: String { address + subject + body }

  public let address: String,
             subject: String,
             body: String,
             attachment: PDF?

  public init(address: String, subject: String, body: String, attachment: PDF?) {
    self.address = address
    self.subject = subject
    self.body = body
    self.attachment = attachment
  }

  @MainActor
  public func sendMail(from viewController: UIViewController) {
    guard MFMailComposeViewController.canSendMail() else {
      print("Mail services are not available.")
      return
    }

    let mailComposeVC = MFMailComposeViewController()
    mailComposeVC.setToRecipients([address])
    mailComposeVC.setSubject(subject)
    mailComposeVC.setMessageBody(body, isHTML: false)

    if let attachment {
      mailComposeVC.addAttachmentData(attachment, mimeType: "application/pdf", fileName: attachment)
    }

    mailComposeVC.mailComposeDelegate = viewController as? MFMailComposeViewControllerDelegate

    viewController.present(mailComposeVC, animated: true)
  }
}
