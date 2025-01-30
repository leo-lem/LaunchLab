//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Foundation
import LLExtensions
import UIComponents
import UIKit

extension Email {
  static let support = Email(
    address: "support@screenlessapp.com",
    subject: "Support",
    body:
    """
    Application Name: \(Bundle.main.displayName)
    iOS: \(UIDevice.current.systemVersion)
    Device Model: \(UIDevice.current.modelName)
    App Version: \(Bundle.main.appVersion)
    App Build: \(Bundle.main.appBuild)
    Bitte gib dein Anliegen unten ein.
    ----------------------------------------
    """
  )

  static let feedback = Email(
    address: "feedback@screenlessapp.com",
    subject: "Feedback",
    body:
    """
    Application Name: \(Bundle.main.displayName)
    iOS: \(UIDevice.current.systemVersion)
    Device Model: \(UIDevice.current.modelName)
    App Version: \(Bundle.main.appVersion)
    App Build: \(Bundle.main.appBuild)
    Bitte gib dein Anliegen unten ein.
    ----------------------------------------
    """
  )
}
