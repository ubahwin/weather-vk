import MapKit
import Combine

protocol IWeatherReducer {
    func loadWeather()
    func loadForecast()
    func reloadData()
    func loadCity(from search: String)

    func sinkToData(_ reloadData: @escaping () -> Void)
}

struct WeatherReducer: IWeatherReducer {
    private let appState: AppState
    private let weatherWebRepository: IWeatherWebRepository
    private let locationManager: ILocationManager

    private let forecastFormatter = ForecastFormatter()

    private let cancelBag = CancelBag()

    init(
        appState: AppState,
        weatherWebRepository: IWeatherWebRepository,
        locationManager: ILocationManager
    ) {
        self.appState = appState
        self.weatherWebRepository = weatherWebRepository
        self.locationManager = locationManager

        _ = loadCity()
        observingPhoneRotate()
    }

    func loadCity(from search: String) {
        locationManager.loadCities(from: search)
            .sink { cities in
                appState.cityList = cities
            }
            .store(in: cancelBag)
    }

    func reloadData() {
        loadForecast()
        loadWeather()
    }

    func loadForecast() {
        loadCity()
            .sink { _ in
                guard let coordinates = appState.currentCity?.coordinates else {
                    return
                }

                loadForecast(from: coordinates)
            }
            .store(in: cancelBag)
    }

    func loadWeather() {
        loadCity()
            .sink { _ in
                guard let coordinates = appState.currentCity?.coordinates else {
                    return
                }

                loadWeather(from: coordinates)
            }
            .store(in: cancelBag)
    }

    private func loadCity() -> AnyPublisher<Void, Never> {
        if appState.currentCity != nil {
            return Just(()).eraseToAnyPublisher()
        }

        return locationManager.loadCurrentCity()
            .map { city in
                appState.currentCity = city
            }
            .eraseToAnyPublisher()
    }

    private func loadWeather(from coordinates: CLLocationCoordinate2D) {
        weatherWebRepository.loadWeather(coordinates: coordinates)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    Log.error(error.localizedDescription)
                }
            }, receiveValue: { weather in
                appState.currentWeather = weather
            })
            .store(in: cancelBag)
    }

    private func loadForecast(from coordinates: CLLocationCoordinate2D) {
        weatherWebRepository.loadForecast(coordinates: coordinates)
            .map { dirtyForecast in
                forecastFormatter.clean(dirtyForecast: dirtyForecast)
            }
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    Log.error(error.localizedDescription)
                }
            }, receiveValue: { forecast in
                appState.forecast = forecast
            })
            .store(in: cancelBag)
    }

    func sinkToData(_ reloadData: @escaping () -> Void) {
        appState.$forecast
            .sink { _ in
                reloadData()
            }
            .store(in: cancelBag)
    }

    private func observingPhoneRotate() {
        locationManager.phoneRotateDegrees
            .assign(to: &appState.$phoneRotateDegrees)
    }

    // MARK: Utility

    static var stub: Self {
        WeatherReducer(
            appState: AppState(),
            weatherWebRepository: StubWeatherWebRepository(),
            locationManager: LocationManager()
        )
    }
}
