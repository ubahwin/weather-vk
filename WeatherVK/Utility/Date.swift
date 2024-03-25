import Foundation

extension Date {
    private static let dateFormatter = DateFormatter()

    var dayOfWeek: DayWeek {
        let weekday = Calendar.current.component(.weekday, from: self)
        return DayWeek(rawValue: weekday) ?? .friday
    }

    var title: String {
        Date.dateFormatter.dateFormat = "dd MMMM"
        Date.dateFormatter.locale = Locale(identifier: "ru_RU")

        var title = Date.dateFormatter.string(from: self).lowercased()

        if self.isToday() {
            title += ", сегодня"
        }

        return title
    }

    var isDaytime: Bool {
        let hour = Calendar.current.component(.hour, from: self)
        return hour >= 6 && hour < 21
    }

    func isSameDay(with: Date) -> Bool {
        let cur = Calendar.current.dateComponents([.day, .month, .year], from: self)
        let now = Calendar.current.dateComponents([.day, .month, .year], from: with)
        return cur == now
    }

    func isToday() -> Bool {
        isSameDay(with: Date.now)
    }
}
