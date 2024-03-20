struct Weather {
    var temperature: Int
    var windSpeed: Double
    var windDirectDegrees: Double
    var clouds: Int
}

extension Weather {
    static var stub: Self {
        Self(
            temperature: 2,
            windSpeed: 2,
            windDirectDegrees: 2,
            clouds: 2
        )
    }
}
