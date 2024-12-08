//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import CoreData
import Data
import SnapshotTesting
import SwiftUI
import XCTest

@testable import LaunchLab

final class HomeScreenSnapshotTest: XCTestCase {
  func testHomeScreenSnapshot() {
    assertSnapshot(
      of: HomeScreen(),
      as: .image(layout: .device(config: .iPhone13)),
      named: "HomeScreen"
    )
  }
}
