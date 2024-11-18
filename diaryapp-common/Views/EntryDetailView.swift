import SwiftData
import SwiftUI

struct EntryDetailView: View {
  @State var entry: DiaryEntry

  var body: some View {
    EntryEditor(entry: $entry)
  }
}

#Preview {
  @Previewable @State var sampleDiary = DiaryEntry.sampleDiaries[0]

  return NavigationStack {
    EntryDetailView(entry: sampleDiary)
  }
}
