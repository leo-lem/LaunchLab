//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Styleguide
import SwiftUI

public struct AnswerTextField: View {
  @Binding var text: String
  @State private var textFieldHeight: CGFloat = 40
  private var placeholder: String

  public init(text: Binding<String>, textFieldHeight: CGFloat = 40, placeholder: String) {
    self._text = text
    self.textFieldHeight = textFieldHeight
    self.placeholder = placeholder
  }

  public var body: some View {
    VStack {
      Text(placeholder)
        .foregroundStyle(.black)
        .font(.headline)
        .foregroundStyle(.secondary)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 12)

      TextField(L10n.commonPlaceholder, text: $text, axis: .vertical)
        .lineLimit(3 ... 6)
        .padding(10)
        .background(
          RoundedRectangle(cornerRadius: 12)
            .stroke(Color.gray, lineWidth: 1)
            .background(
              RoundedRectangle(cornerRadius: 12)
                .fill(Color(uiColor: .secondarySystemBackground))
            )
        )
    }
    .onAppear {
      adjustHeight()
    }
  }

  private func adjustHeight() {
    let newHeight = text.isEmpty ? 40 : min(CGFloat(text.count / 40 + 1) * 40, 200)
    textFieldHeight = newHeight
  }
}
