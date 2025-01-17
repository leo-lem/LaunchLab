//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Charts
import Data
import Styleguide
import SwiftUI

/// Stat view, displaying either a chart or numeric completion stats.
struct Stat: View {
  enum Kind { case completed, chart }

  let kind: Kind, complete: Int, total: Int

  var body: some View {
    VStack {
      switch kind {
      case .completed:
        Text(L10n.modulesStatus)
          .font(.headline)
          .bold()

        Text(L10n.modulesCompleted(complete, total))
          .foregroundStyle(.secondary)
          .font(.subheadline)
          .fontWeight(.semibold)

        Spacer()

        Image(.launchingRocket)
          .resizable()
          .scaledToFit()
          .frame(height: 100)

      case .chart:
        Text("Module Chart")
          .font(.headline)
          .bold()
          .padding(.bottom, 4)

        Chart([
          ("Complete", complete),
          ("Incomplete", incomplete)
        ], id: \.0) { entry in
          SectorMark(
            angle: .value("Modules", entry.1),
            innerRadius: .ratio(0.6),
            angularInset: 8
          )
          .cornerRadius(12)
          .foregroundStyle(entry.0 == "Complete" ? Color.purple : Color.pink)
        }
        .chartLegend(.hidden)
        .chartBackground { _ in
          Text(round(progress * 100) / 100, format: .percent)
            .font(.headline)
            .bold()
        }
      }
    }
    .frame(maxWidth: .infinity)
    .padding()
    .background(RoundedRectangle(cornerRadius: 12)
      .foregroundStyle(Color(uiColor: .secondarySystemGroupedBackground)))
  }

  private var incomplete: Int { total - complete }
  private var progress: Double { total == 0 ? 0 : Double(complete) / Double(total) }
}

#Preview {
  List {
    HStack {
      Stat(kind: .chart, complete: 2, total: 10)
      Stat(kind: .completed, complete: 4, total: 10)
    }
  }
}
