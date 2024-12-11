//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Charts
import Data
import SwiftUI

struct ModuleChartView: View {
  let modules: [Module]

  var body: some View {
    let completedCount = modules.filter { $0.isCompleted }.count
    let notCompletedCount = modules.count - completedCount

    let data = [
      ("Completed", completedCount),
      ("Not Completed", notCompletedCount)
    ]

    let progressPercent = Int((Double(completedCount) / Double(completedCount + notCompletedCount)) * 100)

    return VStack {
      Text("Module Chart")
        .font(.headline)
        .bold()
        .padding(.bottom, 4)

      Chart(data, id: \.0) { entry in
        SectorMark(
          angle: .value("Modules", entry.1),
          innerRadius: .ratio(0.6),
          angularInset: 8
        )
        .cornerRadius(12)
        .foregroundStyle(entry.0 == "Completed" ? Color.purple : Color.pink)
      }
      .chartLegend(.hidden)
      .chartBackground { _ in
        Text("\(progressPercent)%")
          .font(.headline)
          .bold()
      }
    }
    .padding()
  }
}
