import Foundation
import SwiftData

@Model
class ImageAttachment {
  var id: String
  var filename: String
  var timestamp: Date

  init(id: String = UUID().uuidString, filename: String, timestamp: Date = Date()) {
    self.id = id
    self.filename = filename
    self.timestamp = timestamp
  }

  static func saveImage(_ image: Data) throws -> ImageAttachment {
    let filename = "\(UUID().uuidString).jpg"
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[
      0]
    let fileURL = documentsDirectory.appendingPathComponent(filename)
    try image.write(to: fileURL)
    return ImageAttachment(filename: filename)
  }

  func loadImage() -> Data? {
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[
      0]
    let fileURL = documentsDirectory.appendingPathComponent(filename)
    return try? Data(contentsOf: fileURL)
  }
}
