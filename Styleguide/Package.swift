// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Styleguide",
  defaultLocalization: "en",
  platforms: [.iOS(.v17)],
  products: [
    .library(
      name: "Styleguide",
      targets: ["Styleguide"]
    )
  ],
  dependencies: [
    .package(path: "LLExtensions")
  ],
  targets: [
    .target(
      name: "Styleguide",
      dependencies: [
        "LLExtensions"
      ]
    )
  ]
)
