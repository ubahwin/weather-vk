import Foundation

struct Forecast {
    var date: Date
    var weather: Weather
}

extension Forecast {
    static var stub: Self {
        Self(date: Date(timeIntervalSince1970: 1711324800), weather: .stub)
    }
}
