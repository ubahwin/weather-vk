import SwiftUI

extension WeatherReducer: EnvironmentKey {
    static var defaultValue: Self { stub }
}

extension EnvironmentValues {
    var weatherReducer: WeatherReducer {
        get { self[WeatherReducer.self] }
        set { self[WeatherReducer.self] = newValue }
    }
}
