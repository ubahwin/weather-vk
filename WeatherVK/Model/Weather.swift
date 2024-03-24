struct Weather {
    var temperature: Int
    var minTemp: Int
    var maxTemp: Int
    var windSpeed: Double
    var windDirectDegrees: Double
    var clouds: Int
    var pressure: Int
    var visibility: Int
}

extension Weather {
    static var stub: Self {
        Self(
            temperature: 2,
            minTemp: 2,
            maxTemp: 3,
            windSpeed: 2,
            windDirectDegrees: 2,
            clouds: 2,
            pressure: 2,
            visibility: 2
        )
    }
}
