import SwiftUI
import SwiftUIIntrospect

struct EntryEditor: View {
  @Environment(\.dismiss) private var dismiss
  @Binding var entry: DiaryEntry

  var body: some View {
    NavigationView {
      VStack(spacing: 16) {
        HStack(spacing: 12) {
          HStack {
            Image(systemName: "location")
              .foregroundColor(.secondary)
            TextField("Location", text: $entry.location)
              .foregroundColor(.secondary)
          }

          HStack(spacing: 4) {
            Menu {
              Picker("Weather", selection: $entry.weather) {
                ForEach(WeatherSymbol.allCases, id: \.self) { weather in
                  Label(
                    weather.rawValue, systemImage: WeatherSymbol.symbolName(for: weather.rawValue))
                }
              }
            } label: {
              Label(entry.weather, systemImage: WeatherSymbol.symbolName(for: entry.weather))
                .foregroundColor(.secondary)
                .font(.subheadline)
            }
          }
        }

        // show date
        HStack {
          Spacer()
          Image(systemName: "calendar")
            .foregroundColor(.secondary)
        
          Text(entry.timestamp, formatter: DateFormatter.chineseDate)
            .foregroundColor(.secondary)
        }

        TextEditor(text: $entry.text)
          .frame(maxHeight: .infinity)
          .padding(8)
          .introspect(.textEditor, on: .iOS(.v18)) { textEditor in
            textEditor.autocapitalizationType = .none
          }
      }
      .padding()
      #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
      #endif
    }
  }
}

#Preview {
  EntryEditor(entry: .constant(DiaryEntry.newEntryNow()))
}
