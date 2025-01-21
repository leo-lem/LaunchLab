//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import LLExtensions
import SwiftUI
import UIComponents

struct Message: Identifiable {
  let content: String
  let fromUser: Bool

  var id: String { content + (fromUser ? "-user" : "") }
}

struct ChatView: View {
  @FocusState private var isTyping
  @State private var message = ""
  @State private var messages = [Message]()

  let send: (String, String) async -> String?

  var body: some View {
    VStack {
      ScrollView {
        ForEach(messages) { message in
          ChatMessageCell(message.content, isFromCurrentUser: message.fromUser)
        }
      }
      .padding(.top, 16)

      chatBar
        .onAppear { isTyping = true }
    }
    .background(Color(hex: "#5A808D"))
  }

  private var chatBar: some View {
    HStack {
      TextField("What's on your mind?", text: $message)
        .focused($isTyping)
        .padding(12)
        .padding(.trailing, 48)
        .onSubmit(triggerSend)

      Button(action: triggerSend) {
        Label("Send", systemImage: "paperplane")
          .labelStyle(.iconOnly)
      }
      .disabled(message.isEmpty)
      .padding(.horizontal)
    }
    .background(Color(.systemGroupedBackground))
    .clipShape(Capsule())
    .font(.subheadline)
    .padding(.horizontal, 20)
    .padding(.bottom, 10)
    .background(Color(hex: "#5A808D"))
  }

  private func triggerSend() {
    Task {
      messages.append(Message(content: message, fromUser: true))
      let prompt = message
      message = ""

      messages.append(Message(content: "", fromUser: false))
      if let response = await send(prompt, "") {
        messages.removeAll { $0.content.isEmpty }
        messages.append(Message(content: response, fromUser: false))
      } else {}
    }
  }
}
