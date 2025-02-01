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
}
