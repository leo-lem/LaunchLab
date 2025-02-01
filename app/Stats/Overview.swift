import SwiftUI

extension Stats {
  /// Short summary of module progress, which can be expanded in sheet view.
  struct Overview: View {
    let complete: Int, total: Int

    var body: some View {
      HStack {
        VStack(alignment: .leading) {
          Text(L10n.modulesCompleted(complete, total))
            .foregroundStyle(.gray)
            .font(.subheadline)

          Text(L10n.modules)
            .foregroundStyle(.black)
            .font(.headline)
            .bold()
        }
        Spacer()
      }
      .padding()
      .background(
        RoundedRectangle(cornerRadius: 16)
          .foregroundStyle(
            LinearGradient(colors: [.highlightStart, .highlightEnd], startPoint: .top, endPoint: .bottom)
          )
          .shadow(radius: 3, x: 3, y: 5)
        )
      .onTapGesture { isExpanded.toggle() }
      .sheet(isPresented: $isExpanded) { Stats(complete: complete, total: total) }
    }

    @State private var isExpanded = false
  }
}

#Preview {
  Stats.Overview(complete: 2, total: 10)
}
