//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import SwiftUI

public struct AnswerBoxView: View {
  @State private var isSelected = false
  private let emoji: String
  private let title: String
  private let subtitle: String?

  public init(emoji: String, title: String, subtitle: String?) {
    self.emoji = emoji
    self.title = title
    self.subtitle = subtitle
  }

  public var body: some View {
    HStack(spacing: 12) {
      Text(emoji)

      VStack(alignment: .leading) {
        Text(title)
          .foregroundStyle(.black)
          .fixedSize(horizontal: false, vertical: true)
          .font(.headline)
          .bold()

        if let subtitle = subtitle {
          Text(subtitle)
            .foregroundStyle(.black)
            .fixedSize(horizontal: false, vertical: true)
            .font(.caption)
            .foregroundColor(.secondary)
        }
      }

      Spacer()

      Image(systemName: isSelected ? "checkmark.circle" : "circle")
        .resizable()
        .frame(width: 20, height: 20)
        .foregroundStyle(isSelected ? Color.accentColor : .gray)
    }
    .contentShape(Rectangle())
    .onTapGesture {
      isSelected.toggle()
    }
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 12)
        .stroke(isSelected ? Color.accentColor : .gray, lineWidth: 2)
    )
  }
}
