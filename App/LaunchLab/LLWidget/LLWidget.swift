//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//
// swiftlint:disable force_unwrapping

import SwiftUI
import WidgetKit

struct Provider: AppIntentTimelineProvider {
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
  }

  func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
    SimpleEntry(date: Date(), configuration: configuration)
  }

  func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
    var entries: [SimpleEntry] = []

    let currentDate = Date()
    for hourOffset in 0 ..< 5 {
      let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
      let entry = SimpleEntry(date: entryDate, configuration: configuration)
      entries.append(entry)
    }

    return Timeline(entries: entries, policy: .atEnd)
  }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
  let configuration: ConfigurationAppIntent
}

struct LLWidgetEntryView: View {
  private let entry: Provider.Entry
  private let modulePercentage: Int
  private let completedCount: Int
  private let moduleCount: Int

  init(entry: Provider.Entry) {
    let completedCount = entry.configuration.completedModules
    let moduleCount = entry.configuration.moduleCount

    self.entry = entry
    self.completedCount = completedCount
    self.moduleCount = moduleCount

    self.modulePercentage = 28
  }

  var body: some View {
    HStack {
      VStack {
        Text("Modules Completed")
          .font(.title2)
          .bold()
          .multilineTextAlignment(.center)
          .padding(.bottom, 10)

        Text("2/7 modules (28%)")
          .font(.subheadline)
          .foregroundStyle(.gray)
          .fontWeight(.semibold)
      }

      Spacer()

      Image(.launchingRocket)
        .resizable()
        .scaledToFit()
        .frame(width: 100)
    }
    .padding(16)
  }
}

struct LLWidget: Widget {
  let kind: String = "LLWidget"

  var body: some WidgetConfiguration {
    AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
      LLWidgetEntryView(entry: entry)
        .containerBackground(.fill.tertiary, for: .widget)
    }
  }
}
