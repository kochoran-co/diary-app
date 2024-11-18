import SwiftUI

struct EntryLocationWeatherView: View {
  @Binding var entry: DiaryEntry

  var body: some View {
    VStack(spacing: 4) {
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
  }
}
