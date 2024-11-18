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
        EntryDateView(timestamp: entry.timestamp)
        EntryLocationWeatherView(entry: $entry)
        EntryImagePickerView(entry: $entry, imageSelection: $imageSelection)
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
