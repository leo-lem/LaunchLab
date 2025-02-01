/// An animated loading indicator.
public struct LoadingDotsView: View {
  public init() {}

  public var body: some View {
    HStack {
      Circle()
        .fill(Color.blue)
        .frame(width: 10, height: 10)
        .scaleEffect(scale)
        .animation(.easeInOut(duration: 0.5).repeatForever(), value: scale)

      Circle()
        .fill(Color.blue)
        .frame(width: 10, height: 10)
        .scaleEffect(scale)
        .animation(.easeInOut(duration: 0.5).repeatForever().delay(0.3), value: scale)

      Circle()
        .fill(Color.blue)
        .frame(width: 10, height: 10)
        .scaleEffect(scale)
        .animation(.easeInOut(duration: 0.5).repeatForever().delay(0.6), value: scale)
    }
    .onAppear { self.scale = 1.0 }
  }

  @State private var scale = 0.5
}

#Preview {
  LoadingDotsView()
}
