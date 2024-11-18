import SwiftUI

struct EntryTextEditorView: View {
  @Binding var text: String

  var body: some View {
    ZStack(alignment: .topLeading) {
      TextEditor(text: $text)
        .frame(maxHeight: .infinity)
        .padding(.vertical, 8)
      if text.isEmpty {
        Text("What's on your mind?")
          .foregroundColor(.secondary)
      }
    }
  }
}
