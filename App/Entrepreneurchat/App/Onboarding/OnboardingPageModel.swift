//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Foundation

struct OnboardingPageModel {
  let question: String
  let subtitle: String?
  let answerType: OnboardingAnswerType
}

struct OnboardingQuestionAnswer {
  let title: String
  let subtitle: String?
  let emoji: String
}
