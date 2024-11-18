import PhotosUI
import SwiftUI

struct EntryImagePickerView: View {
  @Binding var entry: DiaryEntry
  @Binding var imageSelection: PhotosPickerItem?

  var body: some View {
    ImageCarouselView(
      images: entry.images,
      isEditing: true,
      onDelete: { index in
        entry.images.remove(at: index)
      },
      imagePickerBinding: $imageSelection
    )
  }
}
