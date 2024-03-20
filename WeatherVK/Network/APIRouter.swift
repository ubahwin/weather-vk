import Foundation

class APIRouter {
    struct GetCurrentWeatherResponse: Request {
        typealias ReturnType = CurrentWeatherResponse

        var path: String = "/data/2.5/weather"
        var method: HTTPMethod = .get
        var queryParams: [String: Any]?

        init(queryParams: APIParameters.CurrentWeatherParams) {
            self.queryParams = queryParams.asDictionary
        }
    }
}
