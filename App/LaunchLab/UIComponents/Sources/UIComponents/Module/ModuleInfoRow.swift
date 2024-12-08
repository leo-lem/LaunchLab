//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import SwiftUI

public struct ModuleInfoRow: View {
  private let title: String
  private let subtitle: String
  private let image: Image

  public init(title: String, subtitle: String, image: Image) {
    self.title = title
    self.subtitle = subtitle
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

        Text(subtitle)
          .font(.subheadline)
          .foregroundStyle(.secondary)
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}
