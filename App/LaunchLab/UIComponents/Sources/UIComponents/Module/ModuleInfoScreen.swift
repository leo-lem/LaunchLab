//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Styleguide
import SwiftfulRouting
import SwiftUI

public struct ModuleInfoScreen<Content: View>: View {
  @Environment(\.router) var router
  private let title: String
  private let subtitle: String
  private let content: () -> Content
  private let startAction: () -> Void

  public init(title: String, subtitle: String, content: @escaping () -> Content, startAction: @escaping () -> Void) {
    self.title = title
    self.subtitle = subtitle
    self.content = content
    self.startAction = startAction
  }

  public var body: some View {
    VStack {
      Text(title)
        .multilineTextAlignment(.center)
        .font(.largeTitle)
        .bold()
        .padding(.bottom, 20)

      Text(subtitle)
        .multilineTextAlignment(.center)
        .font(.subheadline)
        .bold()
        .padding(.bottom, 50)

      content()

      ActionPrimaryButton(isClickable: true, title: L10n.commonStart, action: startAction)
    }
    .padding(30)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button {
          router.dismissScreen()
        } label: {
          Image(systemName: "xmark.circle")
        }
      }
    }
  }
}

#Preview {
  ModuleInfoScreen(
    title: "Market Analysis",
    subtitle: "The market analysis provides insights into target groups, competition and trends and lays the foundation for well-founded decisions"
  ) {
    Text("Test")
  } startAction: {
    print("STARTET MODULE")
  }
}
