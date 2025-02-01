/// Label styling indicating an external link or action.
public struct ExternalLabelStyle: LabelStyle {
  public let color: Color,
             transfer: Bool

  public init(color: Color, transfer: Bool) {
    self.color = color
    self.transfer = transfer
  }

  public func makeBody(configuration: Configuration) -> some View {
    HStack(spacing: 10) {
      configuration.icon
        .frame(width: 20, height: 20)
        .foregroundStyle(.white)
        .background {
          RoundedRectangle(cornerRadius: 5)
            .frame(width: 30, height: 30)
            .foregroundStyle(color)
        }
        .padding(.vertical, 5)
      configuration.title
      Spacer()
      Image(systemName: transfer ? "arrow.up.right" : "chevron.right")
    }
  }
}

public extension LabelStyle where Self == ExternalLabelStyle {
  static func external(color: Color, transfer: Bool) -> Self {
    .init(color: color, transfer: transfer)
  }
}

#Preview {
  List {
    Button("Preview", systemImage: "document.fill") {}
      .labelStyle(ExternalLabelStyle(color: .red, transfer: false))
  }

  Button("Preview", systemImage: "lock") {}
    .labelStyle(ExternalLabelStyle(color: .green, transfer: true))
    .buttonStyle(.borderedProminent)
    .padding()
}
