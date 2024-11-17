import Foundation

enum WeatherSymbol: String, CaseIterable {
  case sunny = "晴天"
  case rainy = "雨天"
  case cloudy = "阴天"

  var systemImageName: String {
    switch self {
    case .sunny: return "sun.max"
    case .rainy: return "cloud.rain"
    case .cloudy: return "cloud"
    }
  }

  static func symbolName(for weather: String) -> String {
    if let weatherType = WeatherSymbol(rawValue: weather) {
      return weatherType.systemImageName
    }
    return "questionmark"
  }
}
