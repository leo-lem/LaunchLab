//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import SwiftUI
import SwiftfulRouting
import UIComponents

struct FloatingChatButtonView<Content: View>: View {
    @ViewBuilder let content: Content
    @Environment(\.router) private var router
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        ZStack {
            content
            
            FloatingChatButton {
                router.showResizableSheet(
                    sheetDetents: [.large],
                    selection: .constant(.large),
                    showDragIndicator: true) { _ in
                        ChatView()
                            .presentationCornerRadius(16)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        }
    }
}
