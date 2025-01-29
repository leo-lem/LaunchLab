//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Foundation
import Styleguide
import SwiftUI
import UIComponents
import UIKit

extension NavigationButton {
  static let privacy: Self = .init(
    imageString: "lock.rectangle.stack.fill",
    imageColor: .teal,
    text: L10n.privacyPolicy,
    isLinkoutButton: true
  ) {
    if let url = URL(string: "https://www.screenlessapp.com/privacy-policy") {
      UIApplication.shared.open(url)
    }
  }

  static let eula: Self = .init(
    imageString: "doc.plaintext.fill",
    imageColor: .blue,
    text: "EULA",
    isLinkoutButton: true
  ) {
    if let url = URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/") {
      UIApplication.shared.open(url)
    }
  }

  static func support(email: Binding<Email?>) -> Self {
    .init(
      imageString: "questionmark.circle.fill",
      imageColor: .orange,
      text: L10n.support
    ) {
      if MailView.canSend {
        email.wrappedValue = .support
      }
    }
  }

  static func feedback(email: Binding<Email?>) -> Self {
    .init(
      imageString: "envelope.fill",
      imageColor: .blue,
      text: L10n.feedback
    ) {
      if MailView.canSend {
        email.wrappedValue = .feedback
      }
    }
  }
}
