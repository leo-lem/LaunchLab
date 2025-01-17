//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Foundation
import MessageUI
import UIKit

public struct Email: Identifiable {
  public var id: String { address + subject + body }

  public let address: String,
             subject: String,
             body: String,
             attachmentData: Data?,
             attachmentFilename: String?

  public init(address: String, subject: String, body: String, attachmentData: Data? = nil, attachmentFilename: String? = nil) {
    self.address = address
    self.subject = subject
    self.body = body
    self.attachmentData = attachmentData
    self.attachmentFilename = attachmentFilename
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

    if let data = attachmentData, let filename = attachmentFilename {
      mailComposeVC.addAttachmentData(data, mimeType: "application/pdf", fileName: filename)
    }

    mailComposeVC.mailComposeDelegate = viewController as? MFMailComposeViewControllerDelegate

    viewController.present(mailComposeVC, animated: true)
  }
}
