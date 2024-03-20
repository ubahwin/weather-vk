import Foundation

protocol DictionaryConvertor: Codable { }

struct APIParameters {
    struct CurrentWeatherParams: Encodable {
        enum UnitsMeasurement: String, Encodable {
            case standard, metric, imperial
        }

        let lat: Double
        let lon: Double
        let appid: String
        let units: UnitsMeasurement = .metric
    }
}
