//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//
// swiftlint:disable force_unwrapping opening_brace

import Foundation
import Styleguide

class ChatGPTRequester {
  private let key = L10n.apiKey
  private let url = URL(string: "https://api.openai.com/v1/chat/completions")!

  func sendMessage(_ prompt: String) async -> String? {
    do {
      let headers = [
        "Authorization": "Bearer \(key)",
        "Content-Type": "application/json"
      ]

      let body: [String: Any] = [
        "model": "gpt-4",
        "messages": [["role": "user", "content": prompt]],
        "temperature": 0.7
      ]

      var request = URLRequest(url: url)
      request.httpMethod = "POST"
      request.allHTTPHeaderFields = headers
      request.httpBody = try JSONSerialization.data(withJSONObject: body)

      let (data, _) = try await URLSession.shared.data(for: request)

      if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
         let choices = json["choices"] as? [[String: Any]],
         let message = choices.first?["message"] as? [String: Any],
         let content = message["content"] as? String
      {
        return content
      }
    } catch {
      print("Error during request: \(error.localizedDescription)")
    }

    return nil
  }
}
