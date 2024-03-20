import CoreLocation
import Combine

protocol ILocationManager {
    var userLocation: CurrentValueSubject<CLLocationCoordinate2D, Never> { get }
}

class LocationManager: NSObject, CLLocationManagerDelegate, ILocationManager {
    let userLocation = CurrentValueSubject<CLLocationCoordinate2D, Never>(CLLocationCoordinate2D())

    private let locationManager = CLLocationManager()
    private var coordinates: CLLocationCoordinate2D?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            Log.info("\(location.coordinate)")
            userLocation.send(location.coordinate)
            locationManager.stopUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Log.error(error.localizedDescription)
    }
}

class StubLocationManager: ILocationManager {
    var userLocation = CurrentValueSubject<CLLocationCoordinate2D, Never>(CLLocationCoordinate2D())

    init() {
        userLocation.send(CLLocationCoordinate2D(latitude: 1, longitude: 1))
    }
}
