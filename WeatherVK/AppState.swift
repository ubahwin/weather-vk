import SwiftUI
import MapKit

class AppState: ObservableObject {
    @Published var currentWeather: Weather?
    @Published var currentCity: City?
    @Published var forecast: [Forecast]?

    @Published var phoneRotateDegrees: Double = 0

    @Published var cityList: [City] = []
}
