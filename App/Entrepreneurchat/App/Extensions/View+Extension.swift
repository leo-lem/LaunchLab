//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import SwiftUI

extension View {
  @ViewBuilder func ifModifier<Content: View>(_ condition: Bool, @ViewBuilder transform: (Self) -> Content) -> some View {
    if condition {
      transform(self)
    } else {
      self
    }
  }

  @ViewBuilder func ifLetModifier<Content: View, Value>(_ value: Value?, @ViewBuilder transform: (Self, Value) -> Content) -> some View {
    if let value {
      transform(self, value)
    } else {
      self
    }
  }
}
