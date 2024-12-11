//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import SwiftfulRouting
import SwiftUI

public struct FloatingChatButton: View {
    private let action: () -> Void
    private let size: CGFloat = 60

    public init(action: @escaping () -> Void) {
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Image(systemName: "ellipsis.message")
                .font(.title)
                .foregroundColor(.white)
        }
        .frame(width: size, height: size)
        .background(.blue)
        .cornerRadius(size / 2)
        .shadow(radius: 20)
        .padding()
    }
}
