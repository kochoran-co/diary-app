import PhotosUI
import SwiftUI

#if os(iOS)
  import UIKit
#elseif os(macOS)
  import AppKit
#endif

struct ImageCarouselView: View {
  let images: [Data]
  let isEditing: Bool
  var onDelete: ((Int) -> Void)?
  var imagePickerBinding: Binding<PhotosPickerItem?>?

  private func getPlatformImage(from data: Data) -> Image? {
    #if os(iOS)
      if let uiImage = UIImage(data: data) {
        return Image(uiImage: uiImage)
      }
    #elseif os(macOS)
      if let nsImage = NSImage(data: data) {
        return Image(nsImage: nsImage)
      }
    #endif
    return nil
  }

  var body: some View {
    ScrollView(.horizontal) {
      HStack {
        if isEditing {
          PhotosPicker(selection: imagePickerBinding ?? .constant(nil), matching: .images) {
            Image(systemName: "photo.badge.plus")
              .font(.system(size: 30))
              .frame(width: 70, height: 60)
              .background(.gray.secondary)
              .clipShape(RoundedRectangle(cornerRadius: 8))
          }
        }

        ForEach(Array(images.enumerated()), id: \.offset) { index, imageData in
          if let platformImage = getPlatformImage(from: imageData) {
            platformImage
              .resizable()
              .scaledToFill()
              .frame(width: 70, height: 60)
              .clipShape(RoundedRectangle(cornerRadius: 8))
              .contextMenu(if: isEditing) {
                Button(role: .destructive) {
                  onDelete?(index)
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

extension View {
  @ViewBuilder
  func contextMenu(if condition: Bool, @ViewBuilder menu: () -> some View) -> some View {
    if condition {
      contextMenu { menu() }
    } else {
      self
    }
  }
}
