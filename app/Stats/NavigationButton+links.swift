//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Foundation
import SwiftUIComponents
import UIKit

extension NavigationButton {
  static let privacy: Self = .init(
    imageString: "lock.rectangle.stack.fill",
    imageColor: .teal,
    text: L10n.privacyPolicy,
    isLinkoutButton: true
  ) {
    if let url = URL(string: "https://launchlab.leolem.dev/privacy") {
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
}
