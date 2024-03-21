import Foundation

class APIRouter {
    struct GetCurrentWeatherResponse: Request {
        typealias ReturnType = GetWeatherData200Response

        var path: String = "weather"
        var method: HTTPMethod = .get
        var queryParams: [String: Any]?

        init(queryParams: APIParameters.CurrentWeatherParams) {
            self.queryParams = queryParams.asDictionary
        }
    }

    struct GetFiveDayForecastResponse: Request {
        typealias ReturnType = GetWeatherForecast200Response

        var path: String = "forecast"
        var method: HTTPMethod = .get
        var queryParams: [String: Any]?

        init(queryParams: APIParameters.FiveDaysForecastParams) {
            self.queryParams = queryParams.asDictionary
        }
    }
}
