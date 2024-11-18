import SwiftUI

struct EntryPreviewCard: View {
  let entry: DiaryEntry

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      VStack {
        HStack {
          Text(entry.timestamp, formatter: DateFormatter.chineseDate)
          Spacer()
          Image(systemName: WeatherSymbol.symbolName(for: entry.weather))
        }
        HStack {
          Text(entry.location)
            .font(.subheadline)
            .multilineTextAlignment(.leading)
          Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }
      .foregroundStyle(.secondary)

      Text(entry.text)
        .lineLimit(2)
        .font(.body)

      if !entry.images.isEmpty {
        ImageCarouselView(images: entry.images, isEditing: false)
      }
    }
    .padding(.vertical, 8)
  }
}

#Preview {
  EntryPreviewCard(entry: DiaryEntry.sampleDiaries[0])
    .previewWithSampleData()
}
