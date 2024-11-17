import SwiftData
import SwiftUI

struct NewEntry: View {
  @Environment(\.modelContext) private var modelContext
  @State private var diaryEntry = DiaryEntry.newEntryNow()

  var body: some View {
    EntryEditor(entry: $diaryEntry)
      .onDisappear {
        if !diaryEntry.text.isEmpty {
          modelContext.insert(diaryEntry)
        }
      }
  }
}

#Preview {
  NewEntry()
    .modelContainer(for: DiaryEntry.self)
}
