import Data

/// AI Co-Founder communicating with OpenAI backend.
@MainActor
public class CoFounder: ObservableObject, @unchecked Sendable {
  private let context: ModelContext

  public init(_ context: ModelContext) { self.context = context }

  public func getHelp(_ title: String, question: String) async -> String? {
    await prompt("""
      Please give some hints and guidance how to proceed with the following question in the module \(title): \(question)
      Give your answer in bullet points and take into consideration what the user has already answered in the other modules.
      Keep it to two or three short bullet points.
      """)
  }

  public func createDocument(_ type: DocumentType) async -> String? {
    await prompt(type.prompt)
  }

  // swiftlint:disable:next force_cast
  private var key: String { Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String }

  private var systemPrompt: String {
    var base = """
    You are a digital co-founder. Always act professionally.
    Answer directly to the user, never speak about the user!
    This is one-shot prompting, so no further inquiry.
    Your job is to guide the user, make recommedations based on their previously entered information, and provide them with documents and summaries where requested.
    You are provided module titles, questions in the module, and answers given by the user.
    Base all your responses on this information that's found below, especially considering the answers of the user.
    Never refer to any modules which are not below or to questions which have not been answered by the user.
    """
    if let modules = try? context.fetch(FetchDescriptor<Module>()) {
      for module in modules.filter({ $0.isCompleted }) {
        base.append("\n\(module.title)\n")
        for block in module.content {
          if let answer = block.answer {
            base.append("Question: \(block.content). Answer: \(answer).\n")
          }
        }
      }
    }
    return base
  }

  private func prompt(_ content: String) async -> String? {
    // swiftlint:disable:next force_unwrapping
    var request = URLRequest(url: URL(string: "https://api.openai.com/v1/chat/completions")!)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = [
      "Authorization": "Bearer \(key)",
      "Content-Type": "application/json"
    ]

    do {
      request.httpBody = try JSONSerialization.data(withJSONObject: [
        "model": "gpt-4",
        "messages": [
          ["role": "system", "content": systemPrompt],
          ["role": "user", "content": content]
        ],
        "temperature": 0.7
      ])

      let (data, _) = try await URLSession.shared.data(for: request)

      if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
         let choices = json["choices"] as? [[String: Any]],
         let message = choices.first?["message"] as? [String: Any],
         let content = message["content"] as? String {
        return content
      }
    } catch {
      assert(false, "OpenAI request failed: \(error.localizedDescription)")
    }

    return nil
  }
}

public extension CoFounder {
  enum DocumentType: Sendable {
    case elevatorPitch,
         pitchDeck,
         businessPlan

    public init(_ title: String) {
      switch title.lowercased() {
      case "elevator pitch":
        self = .elevatorPitch
      case "pitch deck":
        self = .pitchDeck
      case "business plan":
        self = .businessPlan
      default:
        fatalError("Unsupported document type: \(title)")
      }
    }

    internal var prompt: String {
      switch self {
      case .elevatorPitch:
        """
        Write a paragraph containing an elevator pitch.
        The structure is a short introduction, problem definition, solution, call to action.
        Maximum one sentence for each of these.
        """
      case .pitchDeck:
        """
        Create an descriptive outline for a pitch deck.
        The structure is overview of problem, solution, target market, business model, team and call to action.
        Keep it to one page.
        """
      case .businessPlan:
        """
        Create a comprehensive business plan.
        The structure is detailed description of problem, solution, target market, business model, marketing strategy, financial plan and risk analysis.
        Elaborate on each section as well as you can with the provided information.
        """
      }
    }
  }
}
