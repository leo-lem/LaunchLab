//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

/// Generates a PDF document, which can be shared with the user.
public struct PDF: Sendable {
  public var url: URL?

  public init(_ content: String, title: String, delay: Duration = .zero) async {
    try? await Task.sleep(for: delay)

    let tempDirectory = FileManager.default.temporaryDirectory
    let fileURL = tempDirectory.appendingPathComponent("\(title).pdf")

    do {
      let pdfData = try createPDF(content: content)
      try pdfData.write(to: fileURL)
      url = fileURL
    } catch {
      print("Error generating PDF: \(error.localizedDescription)")
    }
  }

  private func createPDF(content: String) throws -> Data {
    let format = UIGraphicsPDFRendererFormat()
    format.documentInfo = [
      kCGPDFContextCreator: "LaunchLab",
      kCGPDFContextAuthor: "LaunchLab Group"
    ] as [String: Any]

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
