//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import LLExtensions
import SwiftUI

public struct ChatMessageCell: View {
  private let message: String
  private let isFromCurrentUser: Bool

  public init(_ message: String, isFromCurrentUser: Bool) {
    self.message = message
    self.isFromCurrentUser = isFromCurrentUser
  }

  public var body: some View {
    HStack {
      if isFromCurrentUser {
        Spacer()

        Text(message)
          .font(.subheadline)
          .padding(15)
          .background(Color(hex: "#B8C9CF"))
          .foregroundColor(.black)
          .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
          .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
      } else {
        HStack(alignment: .bottom, spacing: 8) {
          Circle()
            .fill(Color.gray)
            .frame(width: 30, height: 30)

          Group {
            if message.isEmpty {
              LoadingDotsView()
            } else {
              Text(message)
            }
          }
          .font(.subheadline)
          .padding(15)
          .background(Color(hex: "#D9D9D9"))
          .foregroundColor(.black)
          .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
          .frame(maxWidth: UIScreen.main.bounds.width / 1.75, alignment: .leading)

          Spacer()
        }
      }
    }
    .padding(.horizontal, 8)
    .padding(.bottom, 15)
  }
}
