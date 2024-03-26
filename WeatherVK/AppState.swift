import SwiftUI
import MapKit

class AppState: ObservableObject {
    @Published var currentWeather: Weather?
    @Published var currentCity: City?
    @Published var forecast: [Forecast]?

    @Published var cityList: [City] = []

    @Published var phoneRotateDegrees: Double = 0
}
