//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import Styleguide
import SwiftfulRouting
import SwiftUI
import UIComponents

/// Lectures include the blocks of learning material.
struct Lecture: View {
  let module: Module

  var body: some View {
    ScrollViewReader { proxy in
      ScrollView {
        VStack(spacing: 46) {
          ForEach(Array(module.content.enumerated()), id: \.offset) { id, item in
            if id <= progress {
              withAnimation {
                Block(isAnswered: Binding { true } set: {
                  if id == progress {
                    canContinue = $0
                  }
                }, content: item)
                  .transition(.move(edge: .bottom).combined(with: .opacity))
                  .id(id)
                  .animation(module.isCompleted ? nil : .default, value: id)
              }
            }
          }
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 100)
      }
      .overlay(alignment: .bottom) {
        AsyncButton(title: progress >= module.length - 1 ? L10n.commonComplete : L10n.commonContinue) {
          if !module.isCompleted {
            progress += 1
            module.progress = Int16(self.progress)
            CoreDataStack.shared.save()
          }

          if module.isCompleted {
            router.dismissScreen()
          }
        }
        .disabled(!canContinue)
      }
      .navigationBarBackButtonHidden()
      .onChange(of: progress) { _, newValue in
        withAnimation(.easeInOut(duration: 0.5)) {
          proxy.scrollTo(newValue, anchor: .top)
        }
      }
      .onAppear {
        progress = Int(module.progress)
      }
      .toolbar(content: toolbar)
    }
  }

  @State private var progress = 0
  @State private var canContinue = false
  @Environment(\.router) private var router

  @ToolbarContentBuilder
  private func toolbar() -> some ToolbarContent {
    ToolbarItem(placement: .topBarLeading) {
      Text("\(progress)/\(module.length)")
        .bold()
        .font(.callout)
        .foregroundStyle(module.gradient)
    }

    ToolbarItem(placement: .principal) {
      ProgressView(value: Double(progress), total: Double(module.length))
        .tint(module.gradient)
    }

    DismissButton(tint: module.gradient)
  }
}

#Preview {
  Lecture(module: .example(0))
}
