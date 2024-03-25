import Foundation

struct DirtyForecast {
    var weatherList: [DirtyWeather]
}

struct DirtyWeather {
    var type: WeatherType
    var timestamp: TimeInterval
    var minTemp: Int
    var maxTemp: Int
    var windSpeed: Double
    var clouds: Int
}
