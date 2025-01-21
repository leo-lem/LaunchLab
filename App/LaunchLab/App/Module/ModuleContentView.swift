//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import SwiftUI
import UIComponents

struct ModuleContentView: View {
  @State private var answer = ""
  let moduleTitle: String
  let content: ModuleContent
  private var markdown: AttributedString {
    (try? AttributedString(
      markdown: content.content,
      options: .init(allowsExtendedAttributes: true, interpretedSyntax: .inlineOnlyPreservingWhitespace)
    )) ?? AttributedString(
      stringLiteral: content.content
    )
  }

  var body: some View {
    Text(content.title)
      .font(.title)
      .fontWeight(.bold)
      .multilineTextAlignment(.center)
      .foregroundStyle(content.module.gradient)

    switch content.contentType {
    case .info:
      Text(markdown)
        .font(.title3)
    case .textfield:
      AnswerTextField(text: $answer, placeholder: markdown) {
        Task {
          answer = await ChatGPTRequester().getHelpFromCoFounder(moduleTitle: moduleTitle, moduleContentTitle: content.title) ?? ""
        }
      }
      .onChange(of: answer) {
        content.module.questionAndAnswer[content.title] = answer

        CoreDataStack.shared.save()
      }
      .onAppear {
        if let module = try? CoreDataStack.shared.mainContext.fetch(Module.fetchRequest()).first(where: { ($0.questionAndAnswer[content.title]?.isEmpty) != nil }) {
          answer = module.questionAndAnswer[content.title] ?? ""
        }
      }
    }
  }
}
