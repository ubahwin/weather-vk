import CoreLocation
import Combine
import MapKit

protocol ILocationManager {
    func loadCurrentCity() -> AnyPublisher<City, Never>
    func loadCities(from search: String) -> AnyPublisher<[City], Never>

    var phoneRotateDegrees: CurrentValueSubject<Double, Never> { get }
}

final class LocationManager: NSObject, CLLocationManagerDelegate, ILocationManager {
    let cityName = CurrentValueSubject<String, Never>("")
    let userLocation = CurrentValueSubject<CLLocationCoordinate2D, Never>(CLLocationCoordinate2D())

    let phoneRotateDegrees = CurrentValueSubject<Double, Never>(0)

    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()

    private let searchRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(),
        span: MKCoordinateSpan(latitudeDelta: 180, longitudeDelta: 360)
    )

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }

    func loadCurrentCity() -> AnyPublisher<City, Never> {
        cityName.zip(userLocation)
            .map { name, location in
                return City(name: name, coordinates: location)
            }
            .eraseToAnyPublisher()
    }

    func loadCities(from search: String) -> AnyPublisher<[City], Never> {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = search
        request.region = searchRegion

        return Future<[City], Never> { promise in
            MKLocalSearch(request: request).start { response, error in
                guard let response = response else {
                    if let error = error {
                        Log.error(error.localizedDescription)
                    }

                    promise(.success([]))
                    return
                }

                print(response.mapItems)

                let cities = response.mapItems.compactMap { mapItem -> City? in
                    guard
                        let cityName = mapItem.name,
                        mapItem.placemark.administrativeArea != nil,
                        mapItem.pointOfInterestCategory == nil
                    else {
                        return nil
                    }

                    return City(name: cityName, coordinates: mapItem.placemark.coordinate)
                }

                promise(.success(cities))
            }
        }
        .eraseToAnyPublisher()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.last?.coordinate else {
            return
        }

        Log.info("Координаты пойманы: \(coordinate)")
        userLocation.send(coordinate)
        getCityName(from: coordinate)

        locationManager.stopUpdatingLocation()
    }

    private func getCityName(from coordinates: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)

        geocoder.reverseGeocodeLocation(location) { (placemarks, _) in
            guard let city = placemarks?.first?.locality else {
                return
            }

            self.cityName.send(city)
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateHeading newHeading: CLHeading
    ) {
        let degrees = newHeading.trueHeading
        phoneRotateDegrees.send(degrees)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Log.error(error.localizedDescription)
    }
}

class StubLocationManager: ILocationManager {
    func loadCities(from search: String) -> AnyPublisher<[City], Never> {
        Just<[City]>([]).eraseToAnyPublisher()
    }

    func loadCurrentCity() -> AnyPublisher<City, Never> {
        Just<City>(.stub).eraseToAnyPublisher()
    }

    let cityName = CurrentValueSubject<String, Never>("")
    let phoneRotateDegrees = CurrentValueSubject<Double, Never>(0)
    let userLocation = CurrentValueSubject<CLLocationCoordinate2D, Never>(CLLocationCoordinate2D())

    init() {
        userLocation.send(CLLocationCoordinate2D(latitude: 1, longitude: 1))
        phoneRotateDegrees.send(1)
        cityName.send("SPb")
    }
}
