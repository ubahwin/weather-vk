import Foundation

struct Forecast {
    var dayweek: DayWeek
    var weather: Weather
}

extension Forecast {
    static var stub: Self {
        Self(dayweek: .friday, weather: .stub)
    }
}
