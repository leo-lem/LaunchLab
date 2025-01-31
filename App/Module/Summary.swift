//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import CoFounder
import Data
import SwiftUIComponents

/// A summary of what the module is about.
struct Summary: View {
  let module: Module
  let isUnlocked: Bool

  var body: some View {
    VStack {
      if module.type != .module {
        Image("\(module.type.rawValue)-large")
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

      if module.type == .module {
        VStack(spacing: 20) {
          ForEach(module.sortedContent.prefix(5)) { block in
            ModuleInfoRow(
              title: block.title,
              content: block.content,
              image: Image(systemName: block.image)
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
    .fullScreenCover(isPresented: $learning) { Lecture(module: module) }
    .sheet(isPresented: $mailing) {
      MailView(email: .consultation(modules: modules, lastModuleTitle: modules.last?.title ?? "XY")) { result in
        switch result {
        case .success:
          complete()
        case .failure(let error):
          print(error.localizedDescription)
        }
        mailing = false
      }
    }
    .alert(L10n.errorOccured, isPresented: $mailAlerting) {} message: { Text(L10n.mailAlertSubtitle) }
  }

  @State private var learning = false
  @State private var mailing = false
  @State private var mailAlerting = false
  @State private var pdf: PDF?
  @Query(filter: #Predicate<Module> { $0.isCompleted }) private var modules: [Module]
  @EnvironmentObject private var coFounder: CoFounder
  @Environment(\.dismiss) private var dismiss
  @Environment(\.colorScheme) private var colorScheme

  private var canBeCompleted: Bool {
    module.type != .module && isUnlocked && !module.isCompleted
  }

  private var label: String {
    guard isUnlocked else { return L10n.locked }

    return switch module.type {
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

  private func complete() {
    module.progress = 1
    dismiss()
  }

  private func action() async {
    switch module.type {
    case .module:
      learning = true
    case .document:
      if let content = await coFounder.createDocument(.init(module.title)) {
        pdf = await PDF(
          content,
          title: module.title,
          delay: .seconds(2)
        )
      }
    case .consultation:
      guard MailView.canSend else { return mailAlerting = true }

      mailing = true
    }
  }
}
