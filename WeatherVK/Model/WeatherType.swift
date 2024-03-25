import SwiftUI

enum WeatherType: String, Codable {
    case clearSky = "Clear sky"
    case clouds = "Clouds"
    case rain = "Rain"
    case thunderstorm = "Thunderstorm"
    case snow = "Snow"
    case mist = "Mist"

    var image: String {
        switch self {
        case .clearSky: "☀️"
        case .clouds: "☁️"
        case .rain: "🌧️"
        case .thunderstorm: "⛈️"
        case .snow: "❄️"
        case .mist: "🌫️"
        }
    }
}
