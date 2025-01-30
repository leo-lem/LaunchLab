//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//
// swiftlint:disable force_unwrapping

import UIKit

public extension UIDevice {
  var modelName: String {
    #if targetEnvironment(simulator)
    let identifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"]!
    #else
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineError = Mirror(reflecting: systemInfo.machine)
    let identifier = machineError.children.reduce("") { identifier, element in
      guard let value = element.value as? Int8, value != 0 else { return identifier }
      return identifier + String(UnicodeScalar(UInt8(value)))
    }
    #endif
    return identifier
  }
}
