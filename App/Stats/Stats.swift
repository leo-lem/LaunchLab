//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import CoreData
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

      #if DEBUG
      Section("Cheats") {
        Button("Unlock Half", action: unlockHalf)
        Button("Unlock All", action: unlockAll)
      }
      #endif

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

  #if DEBUG
  private func unlockHalf() {
    CoreDataStack.shared.mainContext.performAndWait {
      let fetchRequest: NSFetchRequest<Module> = Module.fetchRequest()
      if let modules = try? CoreDataStack.shared.mainContext.fetch(fetchRequest) {
        for index in 0..<modules.count/2 {
          let module = modules.first { $0.index == index }
          if module?.isCompleted ?? true { continue }
          module?.progress = Int16(module?.length ?? 100)
        }
      }
    }
  }

  private func unlockAll() {
    CoreDataStack.shared.mainContext.performAndWait {
      let fetchRequest: NSFetchRequest<Module> = Module.fetchRequest()
      if let modules = try? CoreDataStack.shared.mainContext.fetch(fetchRequest) {
        for module in modules {
          module.progress = Int16(module.length)
        }
      }
    }
  }
  #endif
}

#Preview {
  Stats(complete: 5, total: 10)
}
