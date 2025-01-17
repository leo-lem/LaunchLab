//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import Styleguide
import SwiftfulRouting
import SwiftUI
import UIComponents

extension Module {
  struct Lecture: View {
    let module: Module

    var body: some View {
      ScrollViewReader { proxy in
        ScrollView {
          VStack(spacing: 46) {
            ForEach(Array(module.content.enumerated()), id: \.offset) { id, item in
              if id <= progress {
                withAnimation {
                  Block(content: item)
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
        .overlay(alignment: .bottom, content: button)
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
    @State private var answer = ""
    @Environment(\.dismiss) private var dismiss

    private func button() -> some View {
      ActionPrimaryButton(
        isClickable: true,
        title: progress >= module.length - 1 ? L10n.commonComplete : L10n.commonContinue
      ) {
        if !module.isCompleted {
          progress += 1
          module.progress = Int16(self.progress)
          CoreDataStack.shared.save()
        }

        if module.isCompleted {
          dismiss()
        }
      }
    }

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

      ToolbarItem(placement: .topBarTrailing) {
        Button(action: dismiss.callAsFunction) {
          Image(systemName: "xmark.circle")
        }
        .tint(module.gradient)
      }
    }
  }
}

#Preview {
  Module.Lecture(module: .example(0))
}
