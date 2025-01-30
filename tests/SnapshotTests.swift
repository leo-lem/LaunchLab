//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import SnapshotTesting
import Testing

@testable import LaunchLab

@MainActor
struct SnapshotTests {
  @Test("journey snapshot")
  func journey() {
    assertSnapshot(
      of: Journey(),
      as: .image(layout: .device(config: .iPhone13))
    )
  }

  @Test("module snapshot")
  func module() {
    assertSnapshot(
      of: Summary(module: .example(1), isUnlocked: false),
      as: .image(layout: .device(config: .iPhone13))
    )

    assertSnapshot(
      of: Summary(module: .example(1), isUnlocked: true),
      as: .image(layout: .device(config: .iPhone13))
    )

    assertSnapshot(
      of: Summary(module: .example(2), isUnlocked: true), // document
      as: .image(layout: .device(config: .iPhone13))
    )

    assertSnapshot(
      of: Summary(module: .example(4), isUnlocked: true), // consultation
      as: .image(layout: .device(config: .iPhone13))
    )
  }

  @Test("stats snapshot")
  func stats() {
    assertSnapshot(
      of: Stats(complete: 4, total: 15),
      as: .image(layout: .device(config: .iPhone13))
    )
  }

  @Test("lecture snapshot")
  func lecture() {
    assertSnapshot(
      of: Lecture(module: .example(1)),
      as: .image(layout: .device(config: .iPhone13))
    )
  }
}
