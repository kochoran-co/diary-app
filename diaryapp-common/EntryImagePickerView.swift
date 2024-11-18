import PhotosUI
import SwiftUI

struct EntryImagePickerView: View {
  @Binding var entry: DiaryEntry
  @Binding var imageSelection: PhotosPickerItem?

  var body: some View {
    ScrollView(.horizontal) {
      HStack {
        PhotosPicker(selection: $imageSelection, matching: .images) {
          Image(systemName: "photo.badge.plus")
            .font(.system(size: 30))
            .frame(width: 70, height: 60)
            .background(Color(UIColor.systemGray6))
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
  }
}
