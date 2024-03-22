import SwiftUI
import MapKit

class AppState: ObservableObject {
    @Published var currentWeather: Weather?
    @Published var currentCity: String?
    @Published var forecast: [Forecast]?

    @Published var userCoordinates: CLLocationCoordinate2D?
    @Published var phoneRotateDegrees: Double = 0
}
