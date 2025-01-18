//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Styleguide
import SwiftUI

extension Stats {
  /// Short summary of module progress, which can be expanded in sheet view.
  struct Overview: View {
    let complete: Int, total: Int

    var body: some View {
      VStack(alignment: .leading) {
        Text(L10n.modulesCompleted(complete, total))
          .foregroundStyle(.gray)
          .font(.subheadline)

        Text(L10n.modules)
          .foregroundStyle(.black)
          .font(.headline)
          .bold()
      }
      .padding(.horizontal, 40)
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(background)
      .padding(.top, 20)
      .frame(maxHeight: .infinity, alignment: .top)
      .onTapGesture {
        isExpanded.toggle()
      }
      .sheet(isPresented: $isExpanded) { Stats(complete: complete, total: total) }
    }

    @State private var isExpanded = false

    private var background: some View {
      RoundedRectangle(cornerRadius: 16)
        .padding(.horizontal, 10)
        .foregroundStyle(
          LinearGradient(
            gradient: Gradient(colors: [
              Color(red: 248 / 255, green: 227 / 255, blue: 206 / 255),
              Color(red: 228 / 255, green: 183 / 255, blue: 181 / 255)
            ]),
            startPoint: .top,
            endPoint: .bottom
          )
        )
        .frame(width: UIScreen.main.bounds.width - 20, height: 75)
        .shadow(radius: 3, x: 3, y: 5)
    }
  }
}

#Preview {
  Stats.Overview(complete: 2, total: 10)
}
