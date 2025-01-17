//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import MessageUI
import Styleguide
import SwiftUI
import UIComponents

/// Stats and other relevant app information.
struct Stats: View {
  let complete: Int, total: Int

  var body: some View {
    List {
      Section(L10n.yourState.uppercased()) {
        HStack(spacing: 10) {
          Stat(kind: .completed, complete: complete, total: total)
          Stat(kind: .chart, complete: complete, total: total)
        }
      }
      .listRowBackground(Color.clear)
      .listRowSeparator(.hidden)

      Section(L10n.general) {
        NavigationButton.privacy
        NavigationButton.eula
      }

      Section(L10n.supportAndFeedback) {
        NavigationButton.support(email: $email)
        NavigationButton.feedback(email: $email)
      }

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
    .foregroundStyle(.text)
    .sheet(item: $email) { email in
      MailView(email: email) { result in
        switch result {
        case .success:
          print("Email sent")
        case .failure(let error):
          print(error.localizedDescription)
          self.error = true
        }
      }
    }
    .alert(isPresented: $error) {
      Alert(
        title: Text(L10n.errorOccured),
        message: Text(L10n.configureMailApp),
        dismissButton: .default(Text("OK"))
      )
    }
  }

  @State private var email: Email?
  @State private var error = false
}

#Preview {
  Stats(complete: 5, total: 10)
}
