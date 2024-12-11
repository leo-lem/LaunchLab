//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//
// swiftlint: disable force_try

import AppIntents
import Data
import WidgetKit

struct ConfigurationAppIntent: WidgetConfigurationIntent {
  static var title: LocalizedStringResource { "Configuration" }
  static var description: IntentDescription { "This is an example widget." }

  @Parameter(title: "CompletedModules")
  var completedModules: Int?

  @Parameter(title: "ModuleCount")
  var moduleCount: Int?

  init(completedModules: Int, moduleCount: Int) {
    let fetchResult = try! CoreDataStack.shared.mainContext.fetch(Module.fetchRequest())
    self.moduleCount = fetchResult.count
    self.completedModules = fetchResult.filter { $0.isCompleted }.count
  }

  init() {
    let fetchResult = try! CoreDataStack.shared.mainContext.fetch(Module.fetchRequest())
    self.moduleCount = fetchResult.count
    self.completedModules = fetchResult.filter { $0.isCompleted }.count
  }
}
