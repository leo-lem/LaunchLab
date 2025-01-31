//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import CoFounder
import Data
import SwiftUIComponents

extension Lecture {
  /// The actual content is displayed in these blocks.
  struct Block: View {
    let content: Content
    @Binding var isAnswered: Bool

    var body: some View {
      Text(content.title)
        .font(.title)
        .fontWeight(.bold)
        .multilineTextAlignment(.center)
        .padding(.bottom, 12)
        .foregroundStyle(
          content.module?.gradient ?? LinearGradient(colors: [.secondary], startPoint: .bottom, endPoint: .top)
        )

      switch content.type {
      case .info:
        Text(markdown)
          .font(.title3)
          .onAppear { isAnswered = true }
      case .textfield:
        AnswerTextField(
          Binding { content.answer ?? "" } set: {
            content.answer = $0
            isAnswered = !(content.answer?.isEmpty ?? true)
          },
          coFounderTip: CoFounderTip(),
          question: markdown,
          hideCoFounder: content.module?.index ?? -1 == 0
        ) {
          await coFounder.getHelp(content.module?.title ?? "", question: content.content)
        }
        .onAppear { isAnswered = !(content.answer?.isEmpty ?? true) }
      }
    }

    @EnvironmentObject private var coFounder: CoFounder

    private var markdown: AttributedString {
      (try? AttributedString(
        markdown: content.content,
        options: .init(allowsExtendedAttributes: true, interpretedSyntax: .inlineOnlyPreservingWhitespace)
      )) ?? AttributedString(
        stringLiteral: content.content
      )
    }
  }
}
