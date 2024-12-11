//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import Styleguide
import SwiftfulRouting
import SwiftUI
import UIComponents

struct ModuleInfo: View {
  let module: Module

  public var body: some View {
    VStack {
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

      VStack(spacing: 20) {
        ForEach(module.content.prefix(5), id: \.self) { content in
          ModuleInfoRow(
            title: content.title,
            content: content.content,
            image: Image(systemName: content.image)
          )
        }

        if module.content.count > 5 {
          Text("…")
        }
      }

      ActionPrimaryButton(
        isClickable: true,
        title: module.isCompleted ? "Review" :
          module.progress == 0 ? L10n.commonStart : L10n.commonContinue
      ) {
        router.showScreen(.fullScreenCover) { _ in
          LearningView(module)
        }
      }
    }
    .padding(30)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button(action: dismiss.callAsFunction) {
          Image(systemName: "xmark.circle")
        }
        .tint(module.gradient)
      }
    }
  }

  @Environment(\.router) private var router
  @Environment(\.dismiss) private var dismiss
}

#Preview {
  ModuleInfo(module: .example(1))
}
