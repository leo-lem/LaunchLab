import Data
import SwiftUIComponents

/// Lectures include the blocks of learning material.
struct Lecture: View {
  let module: Module

  var body: some View {
    NavigationStack {
      ScrollViewReader { proxy in
        ScrollView {
          VStack(spacing: 46) {
            ForEach(module.sortedContent) { block in
              if block.index <= progress {
                withAnimation {
                  Block(
                    content: block,
                    isAnswered: Binding { true } set: {
                      if block.index == progress {
                        canContinue = $0
                      }
                    }
                  )
                  .transition(.move(edge: .bottom).combined(with: .opacity))
                  .id(block.index)
                  .animation(module.isCompleted ? nil : .default, value: block.index)
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
              module.progress = self.progress
            }

            if module.isCompleted {
              dismiss()
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
  }

  @State private var progress = 0
  @State private var canContinue = false
  @Environment(\.dismiss) private var dismiss

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
      DismissButton()
        .tint(module.gradient)
    }
  }
}
