//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Styleguide
import SwiftUI

public struct BalloonPopupView: View {
  let title: String
  let progress: String
  let gradient: LinearGradient
  let isTriangleOnTop: Bool
  let isButtonDisabled: Bool
  let buttonAction: () -> Void

  public init(
    title: String,
    progress: String,
    gradient: LinearGradient,
    isTriangleOnTop: Bool,
    isButtonDisabled: Bool,
    buttonAction: @escaping () -> Void
  ) {
    self.title = title
    self.progress = progress
    self.gradient = gradient
    self.isTriangleOnTop = isTriangleOnTop
    self.isButtonDisabled = isButtonDisabled
    self.buttonAction = buttonAction
  }

  public var body: some View {
    VStack(alignment: .center, spacing: 8) {
      moduleTitle
      moduleDescription
      continueButton
    }
    .padding()
    .background(
      BalloonBackground(isTriangleOnTop: isTriangleOnTop)
        .fill(gradient)
        .padding(.horizontal, 5)
        .shadow(radius: 4)
    )
    .frame(maxWidth: 200)
    .zIndex(10)
  }

  private var moduleTitle: some View {
    Text(title)
      .font(.headline)
      .foregroundColor(.white)
      .multilineTextAlignment(.center)
  }

  private var moduleDescription: some View {
    Text(progress)
      .multilineTextAlignment(.center)
      .font(.subheadline)
      .foregroundColor(.white)
      .lineLimit(2)
  }

  private var continueButton: some View {
    Button(action: buttonAction) {
      Text(L10n.commonStart)
        .font(.subheadline)
        .fontWeight(.bold)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(isButtonDisabled ? Color.gray.opacity(0.9) : Color.white.opacity(0.9))
        .cornerRadius(12)
        .foregroundColor(isButtonDisabled ? .white : .black)
    }
    .disabled(isButtonDisabled)
  }
}

private struct BalloonBackground: Shape {
  var isTriangleOnTop: Bool

  func path(in rect: CGRect) -> Path {
    var path = Path()
    let cornerRadius: CGFloat = 16
    let triangleHeight: CGFloat = 10

    if isTriangleOnTop {
      let midX = rect.midX
      path.move(to: CGPoint(x: midX - 10, y: triangleHeight))
      path.addLine(to: CGPoint(x: midX, y: 0))
      path.addLine(to: CGPoint(x: midX + 10, y: triangleHeight))
      path.closeSubpath()

      path.addRoundedRect(
        in: CGRect(
          x: 0,
          y: triangleHeight,
          width: rect.width,
          height: rect.height - triangleHeight
        ),
        cornerSize: CGSize(width: cornerRadius, height: cornerRadius)
      )
    } else {
      path.addRoundedRect(
        in: CGRect(
          x: 0,
          y: 0,
          width: rect.width,
          height: rect.height - triangleHeight
        ),
        cornerSize: CGSize(width: cornerRadius, height: cornerRadius)
      )

      let midX = rect.midX
      path.move(to: CGPoint(x: midX - 10, y: rect.height - triangleHeight))
      path.addLine(to: CGPoint(x: midX, y: rect.height))
      path.addLine(to: CGPoint(x: midX + 10, y: rect.height - triangleHeight))
      path.closeSubpath()
    }

    return path
  }
}
