//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import SwiftUI

public struct NavigationButton: View {
  @State private var backgroundColor: Color = .init(uiColor: UIColor.secondarySystemGroupedBackground)

  let imageString: String?
  let imageColor: Color?
  let text: String
  let trailingText: String?
  let isLinkoutButton: Bool
  let action: () -> Void

  public init(
    imageString: String? = nil,
    imageColor: Color? = nil,
    text: String,
    trailingText: String? = nil,
    isLinkoutButton: Bool = false,
    action: @escaping () -> Void
  ) {
    self.imageString = imageString
    self.imageColor = imageColor
    self.text = text
    self.trailingText = trailingText
    self.isLinkoutButton = isLinkoutButton
    self.action = action
  }

  public var body: some View {
    Button {
      backgroundColor = .init(uiColor: UIColor.tertiaryLabel)
      action()

      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        backgroundColor = .init(uiColor: UIColor.secondaryLabel)
      }
    } label: {
      HStack {
        if let imageString = imageString, let imageColor = imageColor {
          Image(systemName: imageString)
            .frame(width: 20, height: 20)
            .foregroundStyle(.white)
            .background {
              RoundedRectangle(cornerRadius: 4)
                .frame(width: 30, height: 30)
                .foregroundStyle(imageColor)
            }
            .padding(.trailing, 5)
        }

        Text(text)

        Spacer()

        if let trailingText = trailingText {
          Text(trailingText)
        }

        Image(systemName: isLinkoutButton ? "arrow.up.right" : "chevron.right")
          .foregroundStyle(.gray)
      }
    }
    .listRowBackground(backgroundColor)
  }
}
