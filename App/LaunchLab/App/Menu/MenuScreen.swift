//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import Styleguide
import SwiftUI
import UIComponents

struct MenuScreen: View {
  let modules: [Module]

  var body: some View {
    List {
      VStack {
        userTopText
        gridView
      }
      .listRowBackground(Color.clear)
      .listRowSeparator(.hidden)

      generalSection
      supportSection
      copyrightSection
    }
    .sheet(isPresented: $viewModel.showMail) { mailView }
    .alert(isPresented: $viewModel.showMailError) {
      Alert(
        title: Text(L10n.errorOccured),
        message: Text(L10n.configureMailApp),
        dismissButton: .default(Text("OK"))
      )
    }
  }

  @StateObject private var viewModel = MenuScreenViewModel()

  private var userTopText: some View {
    VStack {
      Text(L10n.hello("User"))
        .font(.title2)
        .bold()
        .padding(.bottom, 4)

      Text(L10n.launchingGoodWay)
        .foregroundStyle(.secondary)
        .font(.headline)
        .fontWeight(.semibold)
        .multilineTextAlignment(.center)
        .padding(.bottom, 24)
    }
  }

  private var gridView: some View {
    VStack {
      Text(L10n.yourState.uppercased())
        .font(.footnote)
        .foregroundStyle(.secondary)
        .frame(maxWidth: .infinity, alignment: .leading)

      LazyVGrid(
        columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2),
        spacing: 10
      ) {
        modulesCompletedGridItem
        chartGridItem
        userAnswersGridItem
        pitchDeckGridItem
      }
      .padding(.horizontal, -16)
    }
  }

  private var modulesCompletedGridItem: some View {
    gridItemBackground {} content: {
      VStack {
        Text(L10n.modulesStatus)
          .font(.headline)
          .bold()

        Text(getModuleCompletedText())
          .foregroundStyle(.secondary)
          .font(.subheadline)
          .fontWeight(.semibold)

        Spacer()

        Image(.launchingRocket)
          .resizable()
          .scaledToFit()
          .frame(width: 100)
      }
      .padding()
    }
  }

  private var chartGridItem: some View {
    gridItemBackground {} content: {
      ModuleChartView(modules: Array(modules))
    }
  }

  private var userAnswersGridItem: some View {
    gridItemBackground {} content: {
      HStack {
        VStack {
          Text(L10n.yourAnswers)
            .font(.headline)
            .bold()
            .multilineTextAlignment(.center)

          Text(L10n.editYourAnswers)
            .foregroundStyle(.secondary)
            .font(.subheadline)
            .fontWeight(.semibold)
            .multilineTextAlignment(.center)

          Spacer()

          Image(.penAndRuler)
            .resizable()
            .scaledToFit()
            .frame(width: 100)
        }

        Spacer()

        Image(systemName: "chevron.right")
          .foregroundStyle(.secondary)
      }
      .padding()
    }
  }

  private var pitchDeckGridItem: some View {
    gridItemBackground {} content: {
      VStack {
        Text(L10n.pitchDeck)
          .font(.headline)
          .bold()

        Text(L10n.generatePitchDeck)
          .foregroundStyle(.secondary)
          .font(.subheadline)
          .fontWeight(.semibold)
          .multilineTextAlignment(.center)

        Spacer()

        Button {} label: {
          Text(L10n.generate)
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(RoundedRectangle(cornerRadius: 12).fill(Color.gray))
        }
      }
      .padding()
    }
  }

  @ViewBuilder
  private func gridItemBackground(action: @escaping () -> Void, content: @escaping () -> some View) -> some View {
    Button(action: action) {
      RoundedRectangle(cornerRadius: 12)
        .foregroundStyle(Color(uiColor: .secondarySystemGroupedBackground))
        .frame(height: 200)
        .overlay { content() }
    }
    .buttonStyle(PlainButtonStyle())
  }

  private var generalSection: some View {
    Section(L10n.general) {
      NavigationButton(
        imageString: "lock.rectangle.stack.fill",
        imageColor: .teal,
        text: L10n.privacyPolicy,
        isLinkoutButton: true
      ) {
        if let url = URL(string: "https://www.screenlessapp.com/privacy-policy") {
          UIApplication.shared.open(url)
        }
      }

      NavigationButton(
        imageString: "doc.plaintext.fill",
        imageColor: .blue,
        text: "EULA",
        isLinkoutButton: true
      ) {
        if let url = URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/") {
          UIApplication.shared.open(url)
        }
      }
    }
  }

  private var supportSection: some View {
    Section(L10n.supportAndFeedback) {
      NavigationButton(
        imageString: "questionmark.circle.fill",
        imageColor: .orange,
        text: L10n.support
      ) {
        viewModel.sendSupportMail()
      }

      NavigationButton(
        imageString: "envelope.fill",
        imageColor: .blue,
        text: L10n.feedback
      ) {
        viewModel.sendFeedbackMail()
      }
    }
  }

  private var copyrightSection: some View {
    VStack {
      Text("LaunchLab - \(Bundle.main.appVersion) build \(Bundle.main.appBuild)")
      Text("© 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur.")
    }
    .frame(maxWidth: .infinity, alignment: .center)
    .listRowBackground(Color.clear)
    .font(.footnote)
    .fontWeight(.light)
    .foregroundStyle(.secondary)
    .multilineTextAlignment(.center)
  }

  private func getModuleCompletedText() -> String {
    let totalModules = modules.count
    let completedModules = modules.filter { $0.isCompleted }.count

    return L10n.modulesCompleted(completedModules, totalModules)
  }

  private var mailView: some View {
    MailView(
      supportEmail: viewModel.isSupportMail
        ? SupportEmail.createSupportEmail()
        : SupportEmail.createFeedbackEmail()
    ) { result in
      switch result {
      case .success:
        print("Email sent")
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
}
