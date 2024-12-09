//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Foundation
import MessageUI

final class MenuScreenViewModel: ObservableObject {
  @Published var isSupportMail = false
  @Published var showMail = false
  @Published var showMailError = false

  func sendSupportMail() {
    if MFMailComposeViewController.canSendMail() {
      isSupportMail = true
      showMail = true
    } else {
      showMailError = true
    }
  }

  func sendFeedbackMail() {
    if MFMailComposeViewController.canSendMail() {
      isSupportMail = false
      showMail = true
    } else {
      showMailError = true
    }
  }
}
