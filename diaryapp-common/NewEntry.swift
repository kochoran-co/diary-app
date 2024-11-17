import SwiftData
import SwiftUI

struct NewEntry: View {
  @Environment(\.modelContext) private var modelContext
  @State private var diaryEntry = DiaryEntry.newEntryNow()
  @Environment(\.presentationMode) private var presentationMode

  var body: some View {
    ZStack {
      Text("New Entry")
        .bold()

      HStack {
        Spacer()
        Button("Done") {
          presentationMode.wrappedValue.dismiss()
        }
        .bold()
        .padding()
      }
    }

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
