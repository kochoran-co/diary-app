import SwiftUI

struct EntryDateView: View {
  let timestamp: Date

  var body: some View {
    HStack {
      Image(systemName: "calendar")
        .foregroundColor(.secondary)
      Text(timestamp, formatter: DateFormatter.chineseDate)
        .foregroundColor(.secondary)
      Spacer()
    }
  }
}
