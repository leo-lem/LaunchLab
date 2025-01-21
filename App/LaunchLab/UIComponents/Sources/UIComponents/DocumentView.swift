//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//
// swiftlint:disable discouraged_direct_init

import Styleguide
import SwiftfulRouting
import SwiftUI

public struct DocumentView: View {
  @Environment(\.router) var router
  @Environment(\.colorScheme) var colorScheme
  @State private var pdfURL: URL?
  private let isAvailable: Bool
  private let isCompleted: Bool
  private let documentTitle: String
  private let dismissAction: () -> Void
  private let generateAction: () async -> String

  public init(isAvailable: Bool, isCompleted: Bool, documentTitle: String, dismissAction: @escaping () -> Void, generateAction: @escaping () async -> String) {
    self.isAvailable = isAvailable
    self.isCompleted = isCompleted
    self.documentTitle = documentTitle
    self.dismissAction = dismissAction
    self.generateAction = generateAction
  }

  public var body: some View {
    VStack(spacing: 20) {
      Image("generating")
        .resizable()
        .frame(width: 250, height: 250)

      Text(L10n.generate(documentTitle))
        .font(.title2)
        .bold()
        .multilineTextAlignment(.center)

      Text(L10n.generateGptInfo)
        .font(.subheadline)
        .foregroundStyle(.secondary)
        .multilineTextAlignment(.center)

      Spacer()

      if let pdfFileURL = pdfURL {
        ShareLink(
          item: pdfFileURL,
          preview: SharePreview(documentTitle, image: Image(systemName: "doc.richtext"))
        ) {
          Text(L10n.exportPdf)
            .padding(.vertical)
            .foregroundStyle(Color.white)
            .frame(width: UIScreen.main.bounds.width - 80)
            .background(
              RoundedRectangle(cornerRadius: 40)
                .fill(Color(uiColor: colorScheme == .dark ? .secondarySystemGroupedBackground : .blue))
            )
        }
      } else {
        ActionPrimaryButton(isClickable: true, title: isAvailable ? L10n.generate : L10n.locked) {
          Task {
            await generatePDF()
          }
        }
        .disabled(!isAvailable || isCompleted)
      }

      if isAvailable && !isCompleted {
        Button(L10n.markCompleted) { dismissAction() }
          .padding(.top, -10)
      }
    }
    .padding(.vertical, 20)
    .padding(.horizontal, 30)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button(action: router.dismissScreen) {
          Image(systemName: "xmark.circle")
            .frame(width: 20, height: 20)
        }
      }
    }
  }

  private func generatePDF() async {
    var pdfContent = await generateAction()
    let tempDirectory = FileManager.default.temporaryDirectory
    let fileURL = tempDirectory.appendingPathComponent(documentTitle + ".pdf")

    do {
      if pdfContent.isEmpty {
        throw NSError()
      }
      let pdfData = try createPDF(content: pdfContent)
      try pdfData.write(to: fileURL)
      pdfURL = fileURL
    } catch {
      print("Error generating PDF: \(error.localizedDescription)")
    }
  }

  /// Create PDF data from content
  private func createPDF(content: String) throws -> Data {
    let pdfMetaData = [
      kCGPDFContextCreator: "LaunchLab",
      kCGPDFContextAuthor: "LaunchLab Group"
    ]
    let format = UIGraphicsPDFRendererFormat()
    format.documentInfo = pdfMetaData as [String: Any]

    let pageWidth = 8.5 * 72.0 // 8.5 inches
    let pageHeight = 11.0 * 72.0 // 11 inches
    let pageSize = CGSize(width: pageWidth, height: pageHeight)

    let renderer = UIGraphicsPDFRenderer(bounds: CGRect(origin: .zero, size: pageSize), format: format)
    return renderer.pdfData { context in
      context.beginPage()
      let attributes = [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)
      ]
      content.draw(in: CGRect(x: 20, y: 20, width: pageWidth - 40, height: pageHeight - 40), withAttributes: attributes)
    }
  }
}
