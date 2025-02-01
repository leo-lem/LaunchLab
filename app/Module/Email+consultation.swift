//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import SwiftUIComponents
import UIKit

extension Email {
  static func consultation(modules: [Module], lastModuleTitle: String) -> Email {
    Email(
      address: "transfer@uni-hamburg.de",
      subject: "Consultation LaunchLab",
      body: """
      Liebe Transferagentur,

      ich habe soeben das Modul "\(lastModuleTitle)" in LaunchLab erfolgreich abgeschlossen und möchte nun gerne das kostenlose Beratungsangebot in Anspruch nehmen.

      Ich bitte Sie daher, mir mögliche Termine für ein Gespräch vorzuschlagen.

      Anbei ist der aktuelle Stand meines Startups.

      Vielen Dank im Voraus für Ihre Rückmeldung!

      Mit freundlichen Grüßen
      [DEIN NAME]
      """,
      attachment: summaryPDF(modules: modules)
    )
  }

  static func summaryPDF(modules: [Module]) -> PDF? {
    let summary = modules.filter(\.isCompleted).map(\.title).joined(separator: ", ")
    let answers = modules
      .filter(\.isCompleted)
      .map {
        $0.title + ":\n\t" + $0.sortedContent.compactMap {
          if let answer = $0.answer {
            return "• \($0.title): \(answer)."
          } else {
            return nil
          }
        }
        .joined(separator: "\n\t")
      }
      .joined(separator: "\n\n")
    return PDF("Completed: \(summary)\n––––––––––––––––––––––––\n\(answers)", title: "Summary.pdf")
  }
}
