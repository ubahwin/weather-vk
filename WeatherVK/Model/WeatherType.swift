import SwiftUI

enum WeatherType: String, Codable {
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case scatteredClouds = "scattered clouds"
    case brokenClouds = "broken clouds"
    case showerRain = "shower rain"
    case rain
    case thunderstorm
    case snow
    case mist

    var title: Image {
        switch self {
        case .clearSky: Image(systemName: "sun.max.fill")
        case .fewClouds: Image(systemName: "cloud.fill")
        case .scatteredClouds: Image(systemName: "cloud")
        case .brokenClouds: Image(systemName: "cloud")
        case .showerRain: Image(systemName: "cloud.heavyrain")
        case .rain: Image(systemName: "cloud.rain")
        case .thunderstorm: Image(systemName: "cloud.bolt.rain")
        case .snow: Image(systemName: "snowflake")
        case .mist: Image(systemName: "water.waves")
        }
    }
}
