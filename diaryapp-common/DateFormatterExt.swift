import Foundation

extension DateFormatter {
  static let chineseDate: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "zh_CN")
    formatter.dateFormat = "yyyy年 MM月 dd日"  // Changed to explicit format
    return formatter
  }()
}
