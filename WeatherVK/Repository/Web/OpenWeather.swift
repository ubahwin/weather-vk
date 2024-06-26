import Combine
import MapKit

protocol IWeatherWebRepository {
    func loadWeather(coordinates: CLLocationCoordinate2D) -> AnyPublisher<Weather, NetworkRequestError>
    func loadForecast(coordinates: CLLocationCoordinate2D) -> AnyPublisher<DirtyForecast, NetworkRequestError>
}

struct OpenWeatherWebRepository: IWeatherWebRepository {
    func loadWeather(coordinates: CLLocationCoordinate2D) -> AnyPublisher<Weather, NetworkRequestError> {
        APIClient.dispatch(
            APIRouter.GetCurrentWeatherResponse(queryParams: APIParameters.CurrentWeatherParams(
                lat: coordinates.latitude,
                lon: coordinates.longitude,
                appid: APIConstants.token
            ))
        )
        .map { weatherResponse in
            return Mapper.currentWeatherToModel(weatherResponse)
        }
        .eraseToAnyPublisher()
    }

    func loadForecast(coordinates: CLLocationCoordinate2D) -> AnyPublisher<DirtyForecast, NetworkRequestError> {
        APIClient.dispatch(
            APIRouter.GetFiveDayForecastResponse(queryParams: APIParameters.FiveDaysForecastParams(
                lat: coordinates.latitude,
                lon: coordinates.longitude,
                appid: APIConstants.token
            ))
        )
        .map { forecastResponse in
            return Mapper.forecastResponseToDirtyModel(forecastResponse)
        }
        .eraseToAnyPublisher()
    }
}

struct StubWeatherWebRepository: IWeatherWebRepository {
    func loadForecast(coordinates: CLLocationCoordinate2D) -> AnyPublisher<DirtyForecast, NetworkRequestError> {
        Just<DirtyForecast>.withErrorType(DirtyForecast(weatherList: []), NetworkRequestError.self)
    }

    func loadWeather(coordinates: CLLocationCoordinate2D) -> AnyPublisher<Weather, NetworkRequestError> {
        Just<Weather>.withErrorType(.stub, NetworkRequestError.self)
    }
}
