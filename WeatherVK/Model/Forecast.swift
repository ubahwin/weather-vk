import Foundation

struct Forecast {
    var date: Date
    var weather: Weather
}

extension Forecast {
    static var stub: Self {
        Self(date: Date(), weather: .stub)
    }
}
