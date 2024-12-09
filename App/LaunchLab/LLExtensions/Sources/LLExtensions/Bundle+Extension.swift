//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Foundation

public extension Bundle {
  var displayName: String {
    object(forInfoDictionaryKey: "CFBundleName") as? String ?? "Screenless"
  }

  var appBuild: String {
    object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "1"
  }

  var appVersion: String {
    object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "1.0.0"
  }
}
