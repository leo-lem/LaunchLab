//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import SwiftUIComponents
import TipKit

/// An answer field for submitting text.
public struct AnswerTextField: View {
  @State private var help: String?
  @State private var textFieldHeight: CGFloat = 40

  @Binding var answer: String
  let question: AttributedString
  let coFounderTip: any Tip
  let getHelp: () async -> String?
  let hideCoFounder: Bool

  public init(_ answer: Binding<String>, coFounderTip: any Tip, question: AttributedString, hideCoFounder: Bool = false, getHelp: @escaping () async -> String?) {
    self._answer = answer
    self.coFounderTip = coFounderTip
    self.hideCoFounder = hideCoFounder
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
      }

      if !hideCoFounder {
        VStack {
          if #available(iOS 18.0, *) {
            TipView(coFounderTip)
          }

          AsyncButton(title: L10n.cofounderLabel) { help = await getHelp() }
        }
      }

      TextField(L10n.commonPlaceholder, text: $answer, axis: .vertical)
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
      textFieldHeight = answer.isEmpty ? 40 : min(CGFloat(answer.count / 40 + 1) * 40, 200)
    }
  }
}
