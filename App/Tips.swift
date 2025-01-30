//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Foundation
import TipKit

struct CoFounderTip: Tip {
  var title: Text {
    Text("Get Help from Your Co-Founder")
  }

  var message: Text? {
    Text("Your entered answers will be included in a prompt and sent to ChatGPT for assistance.")
  }
}

struct ModuleTip: Tip {
  var title: Text {
    Text("Understanding Modules")
  }

  var message: Text? {
    Text("Modules provide valuable insights into key topics and guide you through the process of building a startup.")
  }
}
