//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Styleguide
import SwiftUI

public struct AnswerTextField: View {
  @Binding var text: String
  @State private var textFieldHeight: CGFloat = 40
  private var placeholder: AttributedString
  private var generateAction: () -> Void

  public init(text: Binding<String>, textFieldHeight: CGFloat = 40, placeholder: String, generateAction: @escaping () -> Void) {
    self._text = text
    self.textFieldHeight = textFieldHeight
    self.placeholder = AttributedString(stringLiteral: placeholder)
    self.generateAction = generateAction
  }

  public init(text: Binding<String>, textFieldHeight: CGFloat = 40, placeholder: AttributedString, generateAction: @escaping () -> Void) {
    self._text = text
    self.textFieldHeight = textFieldHeight
    self.placeholder = placeholder
    self.generateAction = generateAction
  }

  public var body: some View {
    VStack {
      Text(placeholder)
        .font(.headline)
        .foregroundStyle(.secondary)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 12)

      ActionPrimaryButton(isClickable: true, title: "Ideate with Your Co-Founder 🤖") {
        generateAction()
      }
      .padding(.top, 12)
      .padding(.bottom, 50)

      TextField(L10n.enterTextHere, text: $text, axis: .vertical)
        .lineLimit(3 ... 30)
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
