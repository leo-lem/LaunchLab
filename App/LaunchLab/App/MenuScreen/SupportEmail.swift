//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//
// swiftlint:disable force_unwrapping line_length

import LLExtensions
import Styleguide
import SwiftUI
import UIKit

struct SupportEmail {
  let toAdress: String
  let subject: String
  let messageHeader: String

  var body: String {
    """
    Application Name: \(Bundle.main.displayName)
    iOS: \(UIDevice.current.systemVersion)
    Device Model: \(UIDevice.current.modelName)
    App Version: \(Bundle.main.appVersion)
    App Build: \(Bundle.main.appBuild)
    \(messageHeader)
    ----------------------------------------
    """
  }

  func send(openURL: OpenURLAction) {
    let urlString = "mailto:\(toAdress)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)&body=\(body.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)"

    guard let url = URL(string: urlString) else { return }
    openURL.callAsFunction(url) { accepted in
      if !accepted {
        print("ERROR")
      }
    }
  }

  static func createSupportEmail() -> SupportEmail {
    SupportEmail(toAdress: "support@screenlessapp.com", subject: "Support", messageHeader: "Bitte gib dein Anliegen unten ein.")
  }

  static func createFeedbackEmail() -> SupportEmail {
    SupportEmail(toAdress: "feedback@screenlessapp.com", subject: "Feedback", messageHeader: "Bitte gib dein Feedback unten ein.")
  }
}
