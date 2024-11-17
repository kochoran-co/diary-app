//
//  ContentView.swift
//  diaryapp
//
//  Created by Joel Tan on 16/11/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
  @Environment(\.modelContext) private var modelContext
  @Query(sort: \DiaryEntry.timestamp, order: .reverse) private var entries: [DiaryEntry]
  @State private var isNewEntryPresented = false

  var body: some View {
    NavigationStack {
      List(entries) { entry in
        NavigationLink(destination: EntryDetailView(entry: entry)) {
          EntryPreviewCard(entry: entry)
        }
      }
      .navigationTitle("My Diary")
      .toolbar {
        ToolbarItem(placement: .primaryAction) {
          Button(action: {
            isNewEntryPresented = true
          }) {
            Label("New Entry", systemImage: "plus")
          }
        }
      }
      .sheet(isPresented: $isNewEntryPresented) {
        NewEntry()
      }
    }
  }
}

struct EntryPreviewCard: View {
  let entry: DiaryEntry

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack {
        Text(entry.timestamp.formatted(date: .abbreviated, time: .shortened))
          .font(.subheadline)
        Spacer()
        Label(entry.weather, systemImage: WeatherSymbol.symbolName(for: entry.weather))
          .font(.subheadline)
          .labelStyle(.titleAndIcon)
      }
      .foregroundStyle(.secondary)

      Text(entry.location)
        .font(.caption)

      Text(entry.text)
        .lineLimit(2)
        .font(.body)
    }
    .padding(.vertical, 8)
  }
}

#Preview {
  let previewConfig = ModelConfiguration(isStoredInMemoryOnly: true)
  let container = try! ModelContainer(for: DiaryEntry.self, configurations: previewConfig)

  // Insert sample data
  for diary in DiaryEntry.sampleDiaries {
    container.mainContext.insert(diary)
  }

  return ContentView()
    .modelContainer(container)
}
