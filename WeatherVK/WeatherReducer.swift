import MapKit

protocol IWeatherReducer {
    func loadWeather()
    func loadForecast()

    func sinkToData(_ reloadData: @escaping () -> Void)
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

    func loadForecast() {
        guard let coordinates = appState.userCoordinates else {
            getUserLocation()
            return
        }

        loadForecast(from: coordinates)
    }

    func loadWeather() {
        guard let coordinates = appState.userCoordinates else {
            getUserLocation()
            return
        }

        observingPhoneRotate()
        loadWeather(from: coordinates)
    }

    func sinkToData(_ reloadData: @escaping () -> Void) {
        appState.$forecast
            .sink { _ in
                reloadData()
            }
            .store(in: cancelBag)
    }

    private func loadForecast(from coordinates: CLLocationCoordinate2D) {
        weatherWebRepository.loadForecast(coordinates: coordinates)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    Log.error(error.localizedDescription)
                }
            }, receiveValue: { forecast in
                appState.forecast = forecast
            })
            .store(in: cancelBag)
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

    private func getUserLocation() {
        locationManager.userLocation
            .sink { coordinates in
                appState.userCoordinates = coordinates
                self.loadWeather(from: coordinates)
            }
            .cancel()
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
