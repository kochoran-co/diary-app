import SwiftUI

struct EntryPreviewCard: View {
  let entry: DiaryEntry

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack {
        Text(entry.timestamp, formatter: DateFormatter.chineseDate)
        Spacer()
        Text(entry.location)
        Image(systemName: WeatherSymbol.symbolName(for: entry.weather))
      }
      .foregroundStyle(.secondary)
      .font(.subheadline)

      Text(entry.text)
        .lineLimit(2)
        .font(.body)
    }
    .padding(.vertical, 8)
  }
}

#Preview {
  EntryPreviewCard(entry: DiaryEntry.sampleDiaries[0])
    .previewWithSampleData()
}
