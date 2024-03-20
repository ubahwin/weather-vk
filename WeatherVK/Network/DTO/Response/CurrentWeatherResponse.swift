import Foundation

struct CurrentWeatherResponse: Codable {
    let coord: CoordResponse?
    let weather: [WeatherResponse]?
    let base: String?
    let main: MainResponse?
    let visibility: Int?
    let wind: WindResponse?
    let rain: RainResponse?
    let clouds: CloudsResponse?
    let timeOfDataCalculation: Int?
    let sys: SysResponse?
    let timezone, id: Int?
    let name: String?
    let cod: Int?

    enum CodingKeys: String, CodingKey {
        case coord
        case weather
        case base
        case main
        case visibility
        case wind
        case rain
        case clouds
        case timeOfDataCalculation = "dt"
        case sys
        case timezone
        case id
        case name
        case cod
    }
}

struct CloudsResponse: Codable {
    let all: Int?
}

struct CoordResponse: Codable {
    let lon, lat: Double?
}

struct MainResponse: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, humidity, seaLevel, grndLevel: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

struct RainResponse: Codable {
    let the1H: Double?

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

struct SysResponse: Codable {
    let type, id: Int?
    let country: String?
    let sunrise, sunset: Int?
}

struct WeatherResponse: Codable {
    let id: Int?
    let main, description, icon: String?
}

struct WindResponse: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}
