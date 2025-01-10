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
  let body: String

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
    SupportEmail(toAdress: "support@screenlessapp.com", subject: "Support", body:
      """
      Application Name: \(Bundle.main.displayName)
      iOS: \(UIDevice.current.systemVersion)
      Device Model: \(UIDevice.current.modelName)
      App Version: \(Bundle.main.appVersion)
      App Build: \(Bundle.main.appBuild)
      Bitte gib dein Anliegen unten ein.
      ----------------------------------------
      """)
  }

  static func createFeedbackEmail() -> SupportEmail {
    SupportEmail(toAdress: "feedback@screenlessapp.com", subject: "Feedback", body:
      """
      Application Name: \(Bundle.main.displayName)
      iOS: \(UIDevice.current.systemVersion)
      Device Model: \(UIDevice.current.modelName)
      App Version: \(Bundle.main.appVersion)
      App Build: \(Bundle.main.appBuild)
      Bitte gib dein Anliegen unten ein.
      ----------------------------------------
      """)
  }

  static func createConsultationMail() -> SupportEmail {
    SupportEmail(toAdress: "transferagentur@uni-hamburg.de", subject: "Consultation LaunchLab", body:
      """
      Liebe Transferagentur,

      ich habe soeben das Modul „xy“ in LaunchLab erfolgreich abgeschlossen und möchte nun gerne das kostenlose Beratungsangebot in Anspruch nehmen.

      Ich bitte Sie daher, mir mögliche Termine für ein Gespräch vorzuschlagen.
      
      Anbei ist der aktuelle Stand meines Startups.

      Vielen Dank im Voraus für Ihre Rückmeldung!

      Mit freundlichen Grüßen
      [DEIN NAME]
      """)
  }
}
