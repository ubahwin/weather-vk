import MapKit

protocol IWeatherReducer {
    func loadWeather()
}

struct WeatherReducer: IWeatherReducer {
    private let appState: AppState
    private let weatherWebRepository: IWeatherWebRepository
    private let locationManager: ILocationManager

    private let cancelBag = CancelBag()

    init(
        appState: AppState,
        weatherWebRepository: IWeatherWebRepository,
        locationManager: ILocationManager
    ) {
        self.appState = appState
        self.weatherWebRepository = weatherWebRepository
        self.locationManager = locationManager
    }

    func loadWeather() {
        guard let coordinates = appState.userCoordinates else {
            getUserLocation()
            return
        }

        loadWeather(from: coordinates)
    }

    private func loadWeather(from coordinates: CLLocationCoordinate2D) {
        weatherWebRepository.loadWeather(coordinates: coordinates)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    Log.error(error.localizedDescription)
                }
            }, receiveValue: { weather in
                Log.info("\(weather)")
                appState.currentWeather = weather
            })
            .store(in: cancelBag)
    }

    private func getUserLocation() {
        locationManager.userLocation
            .sink { coordinates in
                appState.userCoordinates = coordinates
                self.loadWeather(from: coordinates)
            }
            .store(in: cancelBag)
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
