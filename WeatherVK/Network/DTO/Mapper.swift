struct Mapper {
    static func currentWeatherToModel(_ curWeatherResponse: CurrentWeatherResponse) -> Weather {
        Weather(
            temperature: Int(curWeatherResponse.main?.temp ?? 0)
        )
    }
}
