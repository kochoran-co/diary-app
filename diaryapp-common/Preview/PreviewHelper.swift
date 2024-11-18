import SwiftData
import SwiftUI

extension View {
  func previewWithSampleData() -> some View {
    let previewConfig = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: DiaryEntry.self, configurations: previewConfig)

    // Insert sample data
    for diary in DiaryEntry.sampleDiaries {
      container.mainContext.insert(diary)
    }

    return self.modelContainer(container)
  }
}
