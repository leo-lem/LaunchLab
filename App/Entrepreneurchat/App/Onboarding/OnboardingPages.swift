//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Foundation
import Styleguide

enum OnboardingPages: Int, Identifiable, Hashable, CaseIterable {
  case motivation = 1
  case targetGroup = 2
  case currentState = 3
  case goals = 4

  var id: Int { rawValue }

  var pageModel: OnboardingPageModel {
    switch self {
    case .motivation:
      .init(
        question: L10n.motivationQuestion,
        subtitle: L10n.motivationSubtitle,
        answerType: .checkboxList(
          [
            .init(title: L10n.motivationAnswerFreedom, subtitle: nil, emoji: "🧑‍💼"),
            .init(title: L10n.motivationAnswerInnovation, subtitle: nil, emoji: "💡"),
            .init(title: L10n.motivationAnswerProblem, subtitle: nil, emoji: "🛠️"),
            .init(title: L10n.motivationAnswerFinancial, subtitle: nil, emoji: "💰")
          ]
        )
      )
    case .targetGroup:
      .init(
        question: L10n.targetGroupQuestion,
        subtitle: L10n.targetGroupSubtitle,
        answerType: .radialList(
          [
            .init(title: L10n.targetGroupAnswerStudents, subtitle: nil, emoji: "📖"),
            .init(title: L10n.targetGroupAnswerProfessionals, subtitle: nil, emoji: "🏢"),
            .init(title: L10n.targetGroupAnswerTechies, subtitle: nil, emoji: "🤖"),
            .init(title: L10n.targetGroupAnswerUnknown, subtitle: nil, emoji: "🤔")
          ]
        )
      )
    case .currentState:
      .init(
        question: L10n.currentStateQuestion,
        subtitle: L10n.currentStateSubtitle,
        answerType: .radialList(
          [
            .init(title: L10n.currentStateAnswerNoIdea, subtitle: nil, emoji: "🌀"),
            .init(title: L10n.currentStateAnswerIdea, subtitle: nil, emoji: "🚀"),
            .init(title: L10n.currentStateAnswerWorking, subtitle: nil, emoji: "⚙️"),
            .init(title: L10n.currentStateAnswerRunning, subtitle: nil, emoji: "📈")
          ]
        )
      )
    case .goals:
      .init(
        question: L10n.goalsQuestion,
        subtitle: L10n.goalsSubtitle,
        answerType: .textfield
      )
    }
  }

  var nextPage: OnboardingPages? {
    switch self {
    case .motivation:
      .targetGroup
    case .targetGroup:
      .currentState
    case .currentState:
      .goals
    case .goals:
      nil
    }
  }
}

enum OnboardingAnswerType {
  case radialList([OnboardingQuestionAnswer])
  case checkboxList([OnboardingQuestionAnswer])
  case textfield
}
