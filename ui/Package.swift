// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SwiftUIComponents",
  platforms: [.iOS(.v17)],
  products: [.library(name: "SwiftUIComponents", targets: ["SwiftUIComponents"])],
  targets: [.target(name: "SwiftUIComponents", path: "src")]
)
