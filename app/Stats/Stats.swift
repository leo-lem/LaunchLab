//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import MessageUI
import SwiftUIComponents

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
        Button("Unlock Half") { unlock(half: true) }
        Button("Unlock All") { unlock(half: false) }
      }
      #endif

      Section(L10n.general) {
        NavigationButton.privacy
        NavigationButton.eula
      }

      VStack {
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
  }

  @Query private var modules: [Module]

  #if DEBUG
  private func unlock(half: Bool) {
    modules.forEach {
      if !half || $0.index < modules.count/2 {
        $0.progress = $0.length
      }
    }
  }
  #endif
}

#Preview {
  Stats(complete: 5, total: 10)
}
