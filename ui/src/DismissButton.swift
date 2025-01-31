//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import SwiftUI

/// The top-trailing x-Button to dismiss modals.
public struct DismissButton<S: ShapeStyle>: ToolbarContent {
  let tint: S

  public init(tint: S = Color.primary) {
    self.tint = tint
  }

  public var body: some ToolbarContent {
    ToolbarItem(placement: .topBarTrailing) {
      Button("Dismiss", systemImage: "xmark.circle", action: dismiss.callAsFunction)
        .labelStyle(.iconOnly)
        .tint(tint)
    }
  }

  @Environment(\.dismiss) private var dismiss
}
