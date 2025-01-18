//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import SwiftUI

/// A special button that executes and visualises asynchronous workloads.
public struct AsyncButton: View {
  let title: String,
      action: () async -> Void

  public init(title: String, action: @escaping () async -> Void) {
    self.title = title
    self.action = action
  }

  public var body: some View {
    Button {
      Task {
        isLoading = true
        await action()
        isLoading = false
      }
    } label: {
      Text(title)
        .opacity(isLoading ? 0 : 1)
        .overlay { if isLoading { LoadingDotsView() } }
        .foregroundStyle(.white)
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background(
          RoundedRectangle(cornerRadius: 40)
            .fill(
              isEnabled
                ? Color(uiColor: colorScheme == .dark ? .secondarySystemGroupedBackground : .blue)
                : .gray
            )
        )
        .padding()
    }
    .disabled(isLoading || !isEnabled)
  }

  @State private var isLoading = false
  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.colorScheme) private var colorScheme
}

#Preview {
  AsyncButton(title: "Do something") {
    try? await Task.sleep(for: .seconds(2))
  }

  AsyncButton(title: "Do something") {}
    .environment(\.isEnabled, false)
}
