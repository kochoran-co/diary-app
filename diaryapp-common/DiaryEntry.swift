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

// Samples generated with Claude 3.5 Sonnet
extension DiaryEntry {
  static var sampleDiaries: [DiaryEntry] {
    [
      DiaryEntry(
        timestamp: .now.addingTimeInterval(-86400),  // yesterday
        weather: "晴天",
        location: "Box Hill Central, Victoria",
        date: .now.addingTimeInterval(-86400),
        text:
          "Spent the afternoon exploring the Asian grocery stores in Box Hill Central. Found some rare Japanese snacks and had the most amazing xiaolongbao at 上海街.",
        images: []
      ),
      DiaryEntry(
        timestamp: .now.addingTimeInterval(-172_800),  // 2 days ago
        weather: "雨天",
        location: "HuTong Dumpling Bar, Little Bourke St",
        date: .now.addingTimeInterval(-172_800),
        text:
          "Ducked into HuTong to escape the Melbourne rain. The steamy windows and warm lighting created such a cozy atmosphere. Their 锅贴 were perfect as always, and watching the dumpling chefs work through the kitchen window was mesmerizing.",
        images: []
      ),
      DiaryEntry(
        timestamp: .now.addingTimeInterval(-259_200),  // 3 days ago
        weather: "阴天",
        location: "Chatswood Chase, NSW",
        date: .now.addingTimeInterval(-259_200),
        text: "Shopping at Chatswood Chase today. Had bubble tea at Chatime.",
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
