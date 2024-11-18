import PhotosUI
import SwiftUI
import SwiftUIIntrospect

struct EntryEditor: View {
  @Environment(\.dismiss) private var dismiss
  @Binding var entry: DiaryEntry
  @State private var imageSelection: PhotosPickerItem?
  @State private var showDeleteButtonForIndex: Int? = nil

  var body: some View {
    NavigationView {
      VStack(spacing: 16) {
        // show date
        HStack {
          Image(systemName: "calendar")
            .foregroundColor(.secondary)

          Text(entry.timestamp, formatter: DateFormatter.chineseDate)
            .foregroundColor(.secondary)
          Spacer()
        }

        VStack(spacing: 4) {  // Adjusted spacing here
          HStack(spacing: 12) {
            HStack {
              Image(systemName: "location")
                .foregroundColor(.secondary)
              TextField("Where did this happen?", text: $entry.location)
            }

            HStack(spacing: 4) {
              Menu {
                Picker("Weather", selection: $entry.weather) {
                  ForEach(WeatherSymbol.allCases, id: \.self) { weather in
                    Label(
                      weather.rawValue,
                      systemImage: WeatherSymbol.symbolName(for: weather.rawValue)
                    )
                    .tag(weather.rawValue)
                  }
                }
              } label: {
                Label(
                  entry.weather,
                  systemImage: WeatherSymbol.symbolName(for: entry.weather)
                )
                .foregroundColor(.secondary)
                .font(.subheadline)
              }
            }
          }

          HStack {
            Text("Tap to edit")
              .font(.caption)
            Spacer()
          }
          .foregroundColor(.secondary)
        }

        ScrollView(.horizontal) {
          HStack {
            PhotosPicker(selection: $imageSelection, matching: .images) {
              Image(systemName: "photo.badge.plus")
                .font(.system(size: 30))
                .frame(width: 70, height: 60)
                .background(Color(UIColor.systemGray6))  // Added background color
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            ForEach(Array(entry.images.enumerated()), id: \.offset) { index, imageData in
              if let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                  .resizable()
                  .scaledToFill()
                  .frame(width: 70, height: 60)
                  .clipShape(RoundedRectangle(cornerRadius: 8))
                  .contextMenu {
                    Button(role: .destructive) {
                      entry.images.remove(at: index)
                    } label: {
                      Label("Delete", systemImage: "trash")
                    }
                  }
              }
            }
          }
          .padding(.vertical, 8)
        }

        Divider()

        ZStack(alignment: .topLeading) {
          TextEditor(text: $entry.text)
            .frame(maxHeight: .infinity)
            .padding(.vertical, 8)

          if entry.text.isEmpty {
            Text("What's on your mind?")
              .foregroundColor(.secondary)
          }
        }

      }
      .padding()
      .onChange(of: imageSelection) { _, newValue in
        Task {
          if let data = try? await newValue?.loadTransferable(type: Data.self) {
            entry.images.append(data)
          }
          imageSelection = nil
        }
      }
      #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
      #endif
    }
  }
}

#Preview {
  EntryEditor(entry: .constant(DiaryEntry.newEntryNow()))
}
