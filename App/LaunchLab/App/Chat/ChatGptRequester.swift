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
  private let contentPromptRel = """
        You are a digital co-founder. Always act professionally.
        Your job is to help the user to progress. I give you module titles and always questions and answers
        for the modules that the user has answered. A module has several questions with answers. Consider them when answering the questions.
  """

  private func fetchModules() -> [Module] {
    (try? CoreDataStack.shared.mainContext.fetch(Module.fetchRequest()).filter { $0.isCompleted }) ?? []
  }

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
    let contentPromptRaw = contentPromptRel + "\nAnswer in bullet points."
    return await sendMessage(
      userPrompt: "The name of the module is: \(moduleTitle). The question is: \(moduleContentTitle)",
      contentPrompt: generateContentPrompt(
        from: fetchModules(),
        contentPromptRaw: contentPromptRaw
      ) // ggf mehrfach button drücken und es sollen unterschiedliche ergebnisse kommen falls nicht automatisch
    )
  }

  private func getUserPromptForDocumentType(documentType: String) -> String {
    """
    Create a document of type "\(documentType)". Take the information you got from the systemPrompt.

    Formatting guidelines:
    - Elevator Pitch: Short introduction, problem definition, solution, call to action. Only one sentence per category.
    - Pitch Deck: Overview of problem, solution, target market, business model, team and call to action.
    - Business Plan: Detailed description of problem, solution, target market, business model, marketing strategy, financial plan and risk analysis.
    Return the result in clear paragraphs that can be easily inserted into a PDF.
    """
  }

  func generateDocumentString(documentType: String) async -> String? {
    let contentPromptRaw: String = contentPromptRel + "\nAnswer in clear paragraphs for a PDF."
    return await sendMessage(
      userPrompt: getUserPromptForDocumentType(documentType: documentType),
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
