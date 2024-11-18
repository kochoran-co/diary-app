import SwiftUI
import SwiftUIIntrospect

struct EntryEditor: View {
  @Environment(\.dismiss) private var dismiss
  @Binding var entry: DiaryEntry

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

        GroupBox {
          HStack(spacing: 12) {
            HStack {
              Image(systemName: "location")
                .foregroundColor(.secondary)
              TextField("Location", text: $entry.location)
                .textFieldStyle(RoundedBorderTextFieldStyle())
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
                .overlay(
                  Image(systemName: "chevron.down")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .offset(x: 4), alignment: .trailing
                )
              }
              .padding(8)
              .background(
                RoundedRectangle(cornerRadius: 8)
                  .fill(Color(UIColor.systemBackground))
                  .shadow(color: .gray.opacity(0.2), radius: 1)
              )
            }
          }
        } label: {
          Text("Entry Details")
            .font(.caption)
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
