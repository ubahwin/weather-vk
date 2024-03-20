import SwiftUI
import MapKit

class AppState: ObservableObject {
    @Published var currentWeather: Weather?
    @Published var userCoordinates: CLLocationCoordinate2D?
}
