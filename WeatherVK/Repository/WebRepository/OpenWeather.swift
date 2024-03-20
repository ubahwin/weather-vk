import Combine
import MapKit

protocol IWeatherWebRepository {
    func loadWeather(coordinates: CLLocationCoordinate2D) -> AnyPublisher<Weather, NetworkRequestError>
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
}

struct StubWeatherWebRepository: IWeatherWebRepository {
    func loadWeather(coordinates: CLLocationCoordinate2D) -> AnyPublisher<Weather, NetworkRequestError> {
        Just<Weather>.withErrorType(Weather(temperature: 123), NetworkRequestError.self)
    }
}
