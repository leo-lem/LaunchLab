//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Styleguide
import SwiftUI

/// An answer field for submitting text.
public struct AnswerTextField: View {
  @Binding var text: String
  let question: AttributedString,
      getHelp: () async -> String?

  public init(text: Binding<String>, question: AttributedString, getHelp: @escaping () async -> String?) {
    self._text = text
    self.question = question
    self.getHelp = getHelp
  }

  public var body: some View {
    VStack {
      Text(question)
        .font(.headline)
        .foregroundStyle(.secondary)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 12)

      if let help {
          ScrollView {
            Text(help)
              .font(.callout)
              .foregroundStyle(.secondary)
              .padding()
          }
          .background(RoundedRectangle(cornerRadius: 12).opacity(0.1))
          .overlay(alignment: .bottomTrailing) { Text("🤖").padding() }
          .padding()
          .frame(maxHeight: 200)
      } else {
        AsyncButton(title: L10n.cofounderLabel) { help = await getHelp() }
      }

      TextField(L10n.commonPlaceholder, text: $text, axis: .vertical)
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
      textFieldHeight = text.isEmpty ? 40 : min(CGFloat(text.count / 40 + 1) * 40, 200)
    }
  }

  @State private var help: String?
  @State private var textFieldHeight: CGFloat = 40
}

#Preview {
  AnswerTextField(text: .constant(""), question: "Hello, there!") {
    """
    This is a comprehensive help answer:
    
    * Keep it in line afsoihoppbpawgbpqebpgjbqejgbqjiebgijqbgbjeb qpwjgbqwpgjb qpjbgqwbgpqg.
    
    * aowegpqjbgpqglkjbgojbgijobg qojkgbqokjw bqokjwgbqokgbw bqko jbqkogjbqksogjbq.
    
    * dgiqwbgobqgbqgoboiwgiowqiog qowigb oiqwbdgioqg qobg oqiwb oiqwb o
    
    I hope this helps!
    """
  }
}
