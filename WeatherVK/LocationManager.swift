import CoreLocation
import Combine

protocol ILocationManager {
    var userLocation: CurrentValueSubject<CLLocationCoordinate2D, Never> { get }
    var phoneRotateDegrees: CurrentValueSubject<Double, Never> { get }
    var cityName: CurrentValueSubject<String, Never> { get }
}

class LocationManager: NSObject, CLLocationManagerDelegate, ILocationManager {
    let userLocation = CurrentValueSubject<CLLocationCoordinate2D, Never>(CLLocationCoordinate2D())
    let phoneRotateDegrees = CurrentValueSubject<Double, Never>(0)
    let cityName = CurrentValueSubject<String, Never>("")

    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }

    private func getCityName(from coordinates: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)

        geocoder.reverseGeocodeLocation(location) { (placemarks, _) in
            guard
                let placemark = placemarks?.first,
                let city = placemark.locality
            else { return }

            self.cityName.send(city)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let coordinate = location.coordinate

            Log.info("Координаты пойманы: \(coordinate)")
            userLocation.send(coordinate)
            getCityName(from: coordinate)

            locationManager.stopUpdatingLocation()
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
    let cityName = CurrentValueSubject<String, Never>("")
    let phoneRotateDegrees = CurrentValueSubject<Double, Never>(0)
    let userLocation = CurrentValueSubject<CLLocationCoordinate2D, Never>(CLLocationCoordinate2D())

    init() {
        userLocation.send(CLLocationCoordinate2D(latitude: 1, longitude: 1))
        phoneRotateDegrees.send(1)
        cityName.send("SPb")
    }
}
