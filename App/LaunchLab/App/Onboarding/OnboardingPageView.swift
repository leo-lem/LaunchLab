//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import LLExtensions
import Styleguide
import SwiftfulRouting
import SwiftUI
import UIComponents

struct OnboardingPageView: View {
  @State private var path: [OnboardingPages] = []

  @State private var text = ""
  @State private var selectedAnswer: Int?

  @Binding var showOnboarding: Bool
  private let onboardingPage: OnboardingPages
  private let router: AnyRouter

  init(showOnboarding: Binding<Bool>, onboardingPage: OnboardingPages, router: AnyRouter) {
    self._showOnboarding = showOnboarding
    self.onboardingPage = onboardingPage
    self.router = router

    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
  }

  var body: some View {
    VStack {
      questionText
      answerList
      Spacer()
      nextButton
    }
    .padding(.horizontal, 16)
    .padding(.bottom, 24)
    .navigationTitle(L10n.questionValueOf(onboardingPage.rawValue, OnboardingPages.allCases.count))
    .navigationBarTitleDisplayMode(.inline)
    .toolbarRole(.editor)
    .ifModifier(onboardingPage.rawValue == 1) { $0.navigationBarBackButtonHidden() }
    .background(
      LinearGradient(
        gradient: Gradient(colors: [
          Color(red: 248/255, green: 227/255, blue: 206/255),
          Color(red: 228/255, green: 183/255, blue: 181/255)
        ]),
        startPoint: .top,
        endPoint: .bottom
      )
    )
  }

  private var questionText: some View {
    VStack {
      Text(onboardingPage.pageModel.question)
        .foregroundStyle(.black)
        .font(.title2)
        .fixedSize(horizontal: false, vertical: true)
        .bold()
        .padding(.bottom, 8)

      if let subtitle = onboardingPage.pageModel.subtitle {
        Text(subtitle)
          .foregroundStyle(.black)
          .fixedSize(horizontal: false, vertical: true)
          .font(.headline)
          .foregroundStyle(.secondary)
      }
    }
    .multilineTextAlignment(.center)
    .padding(.horizontal, 20)
    .padding(.bottom, 20)
  }

  private var answerList: some View {
    VStack(alignment: .leading, spacing: 12) {
      switch onboardingPage.pageModel.answerType {
        case .radialList(let answers):
          ForEach(Array(answers.enumerated()), id: \.offset) { index, answer in
            RadialAnswerBoxView(
              isSelected: index == selectedAnswer,
              emoji: answer.emoji,
              title: answer.title,
              subtitle: answer.subtitle
            ) {
              selectedAnswer = index
            }
          }
        case .checkboxList(let answers):
          ForEach(answers, id: \.title) { answer in
            AnswerBoxView(emoji: answer.emoji, title: answer.title, subtitle: answer.subtitle)
          }
        case .textfield:
          AnswerTextField(text: $text, placeholder: L10n.commonPlaceholder)
      }
    }
    .padding(.horizontal, 20)
  }

  private var nextButton: some View {
    ActionPrimaryButton(isClickable: true, title: L10n.commonContinue) {
      if let nextPage = onboardingPage.nextPage {
        router.showScreen(.push) { router in
          OnboardingPageView(showOnboarding: $showOnboarding, onboardingPage: nextPage, router: router)
        }
      } else {
        showOnboarding = false
      }
    }
  }
}
