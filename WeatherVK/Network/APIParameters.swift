import Foundation

protocol DictionaryConvertor: Codable { }

struct APIParameters {
    enum UnitsMeasurement: String, Encodable {
        case standard, metric, imperial
    }

    struct CurrentWeatherParams: Encodable {
        let lat: Double
        let lon: Double
        let appid: String
        let units: UnitsMeasurement = .metric
    }

    struct FiveDaysForecastParams: Encodable {
        let lat: Double
        let lon: Double
        let appid: String
        let units: UnitsMeasurement = .metric
    }
}
