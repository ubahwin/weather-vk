import Foundation

struct Forecast {
    var dayweek: DayWeek
    var wearher: Weather
}

extension Forecast {
    static var stub: Self {
        Self(dayweek: .friday, wearher: .stub)
    }
}
