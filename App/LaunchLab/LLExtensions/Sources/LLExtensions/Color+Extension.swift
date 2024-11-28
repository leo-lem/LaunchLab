//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//
// swiftlint:disable identifier_name

import SwiftUI

public extension Color {
  init(hex: String) {
    let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
    let scanner = Scanner(string: hex)
    if hex.hasPrefix("#") {
      scanner.currentIndex = hex.index(after: hex.startIndex)
    }

    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >> 8) & 0xFF) / 255.0
    let b = Double(rgb & 0xFF) / 255.0

    self.init(red: r, green: g, blue: b)
  }
}
