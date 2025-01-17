//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import CoreData
import Data
import Foundation
import UIKit

extension Email {
  @MainActor
  static let consultation = Email(
    address: "test@screenlessapp.com",
    subject: "Consultation LaunchLab",
    body: """
  Liebe Transferagentur,

  ich habe soeben das Modul „xy“ in LaunchLab erfolgreich abgeschlossen und möchte nun gerne das kostenlose Beratungsangebot in Anspruch nehmen.

  Ich bitte Sie daher, mir mögliche Termine für ein Gespräch vorzuschlagen.

  Anbei ist der aktuelle Stand meines Startups.

  Vielen Dank im Voraus für Ihre Rückmeldung!

  Mit freundlichen Grüßen
  [DEIN NAME]
  """,
    attachmentData: pdf(),
    attachmentFilename: "StartupOverview.pdf"
  )

  static func pdf() -> Data? {
    let fetchRequest: NSFetchRequest<Module> = Module.fetchRequest()
    fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Module.index, ascending: true)]

    guard let modules = try? CoreDataStack.shared.mainContext.fetch(fetchRequest) else {
      print("Failed to fetch modules.")
      return nil
    }

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
      for answer in module.questionAndAnswer {
        moduleDetailInfoText.append("\n\(answer.key): \(answer.value)")
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
