//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import LLExtensions
import SwiftUI
import UIComponents

struct ChatView: View {
  @State private var messageText = ""

  var body: some View {
    VStack {
      ScrollView {
        ForEach(0 ... 15, id: \.self) { _ in
          ChatMessageCell(isFromCurrentUser: Bool.random())
        }
      }

      bottomSection
    }
    .background(Color(hex: "#5A808D"))
  }

  private var bottomSection: some View {
    ZStack(alignment: .trailing) {
      TextField("Message...", text: $messageText, axis: .vertical)
        .padding(12)
        .padding(.trailing, 48)
        .background(Color(.systemGroupedBackground))
        .clipShape(Capsule())
        .font(.subheadline)

      sendButton
    }
    .padding(.horizontal, 20)
    .padding(.bottom, 10)
    .background(Color(hex: "#5A808D"))
  }

  private var sendButton: some View {
    Button {
      print("Send message")
    } label: {
      Text("Send")
        .fontWeight(.semibold)
    }
    .padding(.horizontal)
  }
}

#Preview {
  ChatView()
}
