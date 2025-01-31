// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "CoFounder",
  platforms: [.iOS(.v17)],
  products: [.library(name: "CoFounder", targets: ["CoFounder"])],
  dependencies: [.package(path: "Data")],
  targets: [.target(name: "CoFounder", dependencies: ["Data"], path: ".")]
)
