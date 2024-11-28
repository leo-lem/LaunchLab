// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "LLExtensions",
  defaultLocalization: "en",
  platforms: [.iOS(.v17)],
  products: [
    .library(
      name: "LLExtensions",
      targets: ["LLExtensions"]
    )
  ],
  targets: [
    .target(
      name: "LLExtensions"
    )
  ]
)
