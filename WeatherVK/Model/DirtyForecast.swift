import Foundation

struct DirtyForecast {
    var weatherList: [DirtyWeather]
}

struct DirtyWeather {
    var timeStamb: TimeInterval
    var minTemp: Int
    var maxTemp: Int
    var windSpeed: Double
    var clouds: Int
}
