//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import SwiftUI

struct ChatBubble: Shape {
  let isFromCurrentUser: Bool

  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(
      roundedRect: rect,
      byRoundingCorners: [
        .topLeft,
        .topRight,
        isFromCurrentUser ? .bottomLeft : .bottomRight
      ],
      cornerRadii: CGSize(width: 16, height: 16)
    )

    return Path(path.cgPath)
  }
}
