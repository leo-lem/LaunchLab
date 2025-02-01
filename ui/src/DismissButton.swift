/// The top-trailing x-Button to dismiss modals.
public struct DismissButton: View {
  public init() {}

  public var body: some View {
    Button("Dismiss", systemImage: "xmark.circle", action: dismiss.callAsFunction)
      .labelStyle(.iconOnly)
  }

  @Environment(\.dismiss) private var dismiss
}
