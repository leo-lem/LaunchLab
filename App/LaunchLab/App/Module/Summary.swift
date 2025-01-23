//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import Styleguide
import SwiftfulRouting
import SwiftUI
import UIComponents

/// A summary of what the module is about.
struct Summary: View {
  @Environment(\.router) private var router
  @Environment(\.colorScheme) private var colorScheme
  @State private var pdf: PDF?

  let module: Module
  let isUnlocked: Bool

  private var canBeCompleted: Bool {
    module.moduleType != .module && isUnlocked && !module.isCompleted
  }

  private var label: String {
    guard isUnlocked else { return L10n.locked }

    return switch module.moduleType {
    case .document:
      pdf == nil ? L10n.generate : L10n.exportPdf
    case .consultation:
      L10n.startConsulting
    case .module:
      if module.isCompleted {
        L10n.review
      } else if module.isStarted {
        L10n.commonContinue
      } else {
        L10n.commonStart
      }
    }
  }

  public var body: some View {
    VStack {
      if module.moduleType != .module {
        Image("\(module.moduleType.rawValue)-large")
          .resizable()
          .scaledToFit()
      }

      Text(module.title)
        .multilineTextAlignment(.center)
        .font(.largeTitle)
        .bold()
        .padding(.bottom, 20)
        .foregroundStyle(module.gradient)

      Text(module.desc)
        .multilineTextAlignment(.center)
        .font(.subheadline)
        .bold()
        .padding(.bottom, 50)

      if module.moduleType == .module {
        VStack(spacing: 20) {
          ForEach(Array(module.content).prefix(5), id: \.title) { content in
            ModuleInfoRow(
              title: content.title,
              content: content.content,
              image: Image(systemName: content.image)
            )
          }
        }
      }

      Spacer()

      if let url = pdf?.url {
        ShareLink(item: url, preview: SharePreview(module.title, image: Image(systemName: "doc.richtext"))) {
          Text(label)
            .foregroundStyle(.white)
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(
              RoundedRectangle(cornerRadius: 40)
                .fill(Color(uiColor: colorScheme == .dark ? .secondarySystemGroupedBackground : .blue))
            )
            .padding()
        }
      } else {
        AsyncButton(title: label, action: action)
          .environment(\.isEnabled, isUnlocked)
      }

      if canBeCompleted {
        Button(L10n.markCompleted, action: complete)
      }
    }
    .padding(30)
    .toolbar { DismissButton(tint: module.gradient) }
  }

  private func complete() {
    module.progress = 1
    CoreDataStack.shared.save()
  }

  private func action() async {
    switch module.moduleType {
    case .module:
      router.showScreen(.fullScreenCover) { _ in
        Lecture(module: module, lectureRouter: router)
      }
    case .document:
      if let content = await CoFounder.shared.createDocument(.init(module.title)) {
        pdf = await PDF(
          content,
          title: module.title,
          delay: .seconds(2)
        )
      }
    case .consultation:
      guard MailView.canSend else {
        return router.showAlert(.alert, title: L10n.errorOccured, subtitle: L10n.mailAlertSubtitle) {}
      }

      router.showScreen(.sheet) { subrouter in
        MailView(email: .consultation) { result in
          switch result {
          case .success:
            complete()
            subrouter.dismissScreen()
          case .failure(let error):
            print(error.localizedDescription)
          }
        }
      }
    }
  }
}

#Preview {
  Summary(module: .example(1), isUnlocked: true)
  Summary(module: .example(2), isUnlocked: true)
}
