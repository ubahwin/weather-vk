struct Mapper {
    static func currentWeatherToModel(_ curWeatherResponse: GetWeatherData200Response) -> Weather {
        Weather(
            temperature: Int(curWeatherResponse.main?.temp ?? 0),
            windSpeed: curWeatherResponse.wind?.speed ?? 0,
            windDirectDegrees: Double(curWeatherResponse.wind?.deg ?? 0),
            clouds: curWeatherResponse.clouds?.all ?? 0
        )
    }

    static func currentForecastToModel(_ curForecastResponse: GetWeatherForecast200Response) -> Forecast {
        return curForecastResponse.list?.compactMap { forecastResponse in
            return Weather(
                temperature: Int(forecastResponse.main?.temp ?? 0),
                windSpeed: forecastResponse.wind?.speed ?? 0,
                windDirectDegrees: Double(forecastResponse.wind?.deg ?? 0),
                clouds: forecastResponse.clouds?.all ?? 0
            )
        } ?? []
    }
}
