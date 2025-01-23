// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "UIComponents",
  defaultLocalization: "en",
  platforms: [.iOS(.v17)],
  products: [
    .library(
      name: "UIComponents",
      targets: ["UIComponents"]
    )
  ],
  dependencies: [
    .package(path: "Styleguide"),
    .package(path: "LLExtensions"),
    .package(url: "https://github.com/SwiftfulThinking/SwiftfulRouting.git", branch: "main")
  ],
  targets: [
    .target(
      name: "UIComponents",
      dependencies: [
        "Styleguide",
        "LLExtensions",
        "SwiftfulRouting"
      ]
    )
  ]
)
