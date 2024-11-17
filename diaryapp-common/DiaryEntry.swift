//
//  DiaryEntry.swift
//  diaryapp
//
//  Created by Joel Tan on 16/11/2024.
//

import Foundation
import SwiftData

@Model
final class DiaryEntry {
  var timestamp: Date
  var weather: String
  var location: String
  var text: String
  @Attribute(.externalStorage, .allowsCloudEncryption) var images: [Data]

  init(
    timestamp: Date, weather: String, location: String, date _: Date, text: String, images: [Data]
  ) {
    self.timestamp = timestamp
    self.weather = weather
    self.location = location
    self.text = text
    self.images = images
  }
}

extension DiaryEntry {
  static var sampleDiaries: [DiaryEntry] {
    [
      DiaryEntry(
        timestamp: .now.addingTimeInterval(-86400),  // yesterday
        weather: "晴天",
        location: "Kyoto Garden",
        date: .now.addingTimeInterval(-86400),
        text:
          "Today I visited the peaceful Zen garden. The stones and moss created a perfect harmony.",
        images: []
      ),
      DiaryEntry(
        timestamp: .now.addingTimeInterval(-172_800),  // 2 days ago
        weather: "雨天",
        location: "Tea House",
        date: .now.addingTimeInterval(-172_800),
        text:
          "The sound of rain drops on the bamboo fountain was incredibly soothing during tea ceremony.",
        images: []
      ),
      DiaryEntry(
        timestamp: .now.addingTimeInterval(-259_200),  // 3 days ago
        weather: "阴天",
        location: "Cherry Blossom Park",
        date: .now.addingTimeInterval(-259_200),
        text: "Watched the petals dance in the wind. Nature's poetry in motion.",
        images: []
      ),
    ]
  }
}

extension DiaryEntry {
  static func newEntryNow() -> DiaryEntry {
    DiaryEntry(
      timestamp: .now,
      weather: "晴天",
      location: "",
      date: .now,
      text: "",
      images: []
    )
  }
}
