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
      attachmentData: pdf(modules: modules),
      attachmentFilename: "StartupOverview.pdf"
    )
  }

  static func pdf(modules: [Module]) -> Data? {
    let pdfData = NSMutableData()
    let pdfMetadata = [
      kCGPDFContextCreator: "LaunchLab",
      kCGPDFContextAuthor: "LaunchLab Group"
    ]

    let pageSize = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4 Size

    UIGraphicsBeginPDFContextToData(pdfData, pageSize, pdfMetadata)
    UIGraphicsBeginPDFPageWithInfo(pageSize, nil)

    var completedModuleText = ""
    for module in modules where module.isCompleted {
      completedModuleText.append("\(module.title), ")
    }

    var moduleDetailInfoText = ""
    for module in modules where module.isCompleted {
      moduleDetailInfoText.append("\n\nInfo about \(module.title):")
      for block in module.content {
        if let answer = block.answer {
          moduleDetailInfoText.append("\n\(block.content): \(answer)")
        }
      }
    }

    let text = "Completed Modules: \(completedModuleText) \n \(moduleDetailInfoText)"
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .left

    let attributes: [NSAttributedString.Key: Any] = [
      .font: UIFont.systemFont(ofSize: 14),
      .paragraphStyle: paragraphStyle
    ]

    text.draw(in: CGRect(x: 50, y: 50, width: pageSize.width - 100, height: pageSize.height - 100), withAttributes: attributes)

    // End the PDF context
    UIGraphicsEndPDFContext()

    return pdfData as Data
  }
}
