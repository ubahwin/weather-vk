import MapKit

struct City {
    var name: String
    var coordinates: CLLocationCoordinate2D

    static var stub: Self {
        Self(name: "", coordinates: CLLocationCoordinate2D())
    }
}
