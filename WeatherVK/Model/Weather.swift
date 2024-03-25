import Foundation

struct Weather {
    var type: WeatherType
    var temperature: Int
    var minTemp: Int
    var maxTemp: Int
    var windSpeed: Double
    var windDirectDegrees: Double
    var clouds: Int
    var pressure: Int
    var visibility: Int

    var pressureInMmHg: Int {
        Int(round(Double(self.pressure) * 0.75))
    }

    var visibilityInKm: Int {
        Int(round(Double(self.visibility) / 1000))
    }
}

extension Weather {
    static var stub: Self {
        Self(
            type: .clearSky,
            temperature: 2,
            minTemp: 2,
            maxTemp: 3,
            windSpeed: 2,
            windDirectDegrees: 2,
            clouds: 2,
            pressure: 2,
            visibility: 2
        )
    }
}
