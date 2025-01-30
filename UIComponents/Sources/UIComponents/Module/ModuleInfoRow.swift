//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import SwiftUI

public struct ModuleInfoRow: View {
  private let title: String
  private let content: String
  private let image: Image

  public init(title: String, content: String, image: Image) {
    self.title = title
    self.content = content
    self.image = image
  }

  public var body: some View {
    HStack(spacing: 12) {
      image
        .resizable()
        .scaledToFit()
        .frame(width: 30)

      VStack(alignment: .leading) {
        Text(title)
          .font(.headline)
          .bold()

        Group {
          if let markdown = try? AttributedString(markdown: content) {
            Text(markdown)
          } else {
            Text(content)
          }
        }
        .lineLimit(1)
        .font(.subheadline)
        .foregroundStyle(.secondary)
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}
