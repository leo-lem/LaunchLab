//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

/// Generates a PDF document, which can be shared with the user.
public struct PDF: Sendable {
  public let url: URL
  public let data: Data

  public var filename: String { url.lastPathComponent }

  public init?(_ content: String, title: String) {
    url = FileManager.default.temporaryDirectory.appendingPathComponent("\(title).pdf")

    do {
      data = try Self.encode(content: content)
      try data.write(to: url)
    } catch {
      assert(false, "PDF could not be created.")
      return nil
    }
  }

  private static func encode(content: String) throws -> Data {
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
