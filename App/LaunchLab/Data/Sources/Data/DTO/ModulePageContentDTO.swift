//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Foundation

public struct ModulePageContentDTO: Codable {
  public let title: String
  public let infoText: String
  public let imageName: String
  public let question: String?
  public let userAnswer: String?
}
