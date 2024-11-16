import SwiftData
import SwiftUI

struct EntryDetailView: View {
  let entry: DiaryEntry

  private var weatherSymbol: String {
    switch entry.weather {
    case "晴天": return "sun.max"
    case "雨天": return "cloud.rain"
    case "阴天": return "cloud"
    default: return "questionmark"
    }
  }

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 16) {
        HStack {
          Text(entry.timestamp.formatted(date: .long, time: .shortened))
          Spacer()
          Label(entry.weather, systemImage: weatherSymbol)
        }
        .foregroundStyle(.secondary)

        Text(entry.location)
          .font(.headline)

        Text(entry.text)
          .font(.body)

        if !entry.images.isEmpty {
          ScrollView(.horizontal, showsIndicators: false) {
            HStack {
              ForEach(entry.images, id: \.self) { imageData in
                if let image = UIImage(data: imageData) {
                  Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(8)
                }
              }
            }
          }
        }
      }
      .padding()
    }
    .navigationBarTitleDisplayMode(.inline)
  }
}

#Preview {
  NavigationStack {
    EntryDetailView(entry: DiaryEntry.sampleDiaries[0])
  }
}
