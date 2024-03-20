struct Mapper {
    static func currentWeatherToModel(_ curWeatherResponse: CurrentWeatherResponse) -> Weather {
        Weather(
            temperature: Int(curWeatherResponse.main?.temp ?? 0),
            windSpeed: curWeatherResponse.wind?.speed ?? 0,
            windDirectDegrees: Double(curWeatherResponse.wind?.deg ?? 0),
            clouds: curWeatherResponse.clouds?.all ?? 0
        )
    }
}
