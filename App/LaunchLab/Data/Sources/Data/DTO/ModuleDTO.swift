//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Foundation

public struct ModuleDTO: Codable {
  public let moduleName: String
  public let moduleDescription: String
  public let isCompleted: Bool
  public let currentPageIndex: Int
  public let pathIndex: Int
  public let pageContent: [ModulePageContentDTO]
  public let collectableImageString: String
  public let planetImageString: String

  public init(
    moduleName: String,
    moduleDescription: String,
    isCompleted: Bool,
    currentPageIndex: Int,
    pathIndex: Int,
    pageContent: [ModulePageContentDTO],
    collectableImageString: String,
    planetImageString: String
  ) {
    self.moduleName = moduleName
    self.moduleDescription = moduleDescription
    self.isCompleted = isCompleted
    self.currentPageIndex = currentPageIndex
    self.pathIndex = pathIndex
    self.pageContent = pageContent
    self.collectableImageString = collectableImageString
    self.planetImageString = planetImageString
  }
}
