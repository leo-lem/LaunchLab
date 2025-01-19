//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//
// swiftlint:disable force_unwrapping opening_brace

import CoreData
import Data
import Foundation
import Styleguide

class ChatGPTRequester {
  private let key = L10n.apiKey
  private let url = URL(string: "https://api.openai.com/v1/chat/completions")!

  /// fetiching `modules`
  private func fetchModules() -> [Module] {
    let context = CoreDataStack.shared.mainContext
    let fetchRequest: NSFetchRequest<Module> = Module.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "isCompleted == true")
    var modules: [Module] = []

    do {
      modules = try context.fetch(fetchRequest)
    } catch {
      print("Cannot read Modules: \(error.localizedDescription)")
    }
    return modules
  }

  /// Generates `contentPrompt` based on User Data
  private func generateContentPrompt(from modules: [Module], contentPromptRaw: String) -> (String) {
    var contentPromptVar = contentPromptRaw
    for module in modules {
      let title = module.title
      let dict = module.questionAndAnswer
      contentPromptVar += "\nModule: \(title)"

      for (key, value) in dict {
        let question = key
        let answer = value
        contentPromptVar += "\nQuestion: \(question). Answer: \(answer)."
      }
    }
    return contentPromptVar
  }

  func getHelpFromCoFounder(moduleTitle: String, moduleContentTitle: String) async -> String? {
    let contentPromptRaw = """
    You are a digital co-founder. Always act professionally.
    Your job is to help the user to progress. I give you module titles and always questions and answers
    for the modules that the user has answered. A module has several questions with answers. Consider them when answering the questions.
    Answer in bullet points.
    """
    return await sendMessage(
      userPrompt: "The name of the module is: \(moduleTitle). The question is: \(moduleContentTitle)",
      contentPrompt: generateContentPrompt(
        from: fetchModules(),
        contentPromptRaw: contentPromptRaw
      )
    )
  }

  private func sendMessage(userPrompt: String, contentPrompt: String) async -> String? {
    do {
      let headers = [
        "Authorization": "Bearer \(key)",
        "Content-Type": "application/json"
      ]

      let body: [String: Any] = [
        "model": "gpt-4",
        "messages": [
          ["role": "system", "content": contentPrompt],
          ["role": "user", "content": userPrompt]
        ],
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
      print("Error during gpt-request: \(error.localizedDescription)")
    }

    return nil
  }
}
