import Foundation

struct Mapper {
    static func currentWeatherToModel(_ curWeatherResponse: GetWeatherData200Response) -> Weather {
        Weather(
            type: WeatherType(rawValue: (curWeatherResponse.weather?.first?.main)!) ?? .clearSky,
            temperature: Int(curWeatherResponse.main?.temp ?? 0),
            minTemp: Int(curWeatherResponse.main?.tempMin ?? 0),
            maxTemp: Int(curWeatherResponse.main?.tempMax ?? 0),
            windSpeed: curWeatherResponse.wind?.speed ?? 0,
            windDirectDegrees: Double(curWeatherResponse.wind?.deg ?? 0),
            clouds: curWeatherResponse.clouds?.all ?? 0,
            pressure: curWeatherResponse.main?.pressure ?? 0,
            visibility: curWeatherResponse.visibility ?? 0
        )
    }

    static func forecastResponseToDirtyModel(_ forecastResponse: GetWeatherForecast200Response) -> DirtyForecast {
        let weatherList = forecastResponse.list?.compactMap { forecastResponse in
            return DirtyWeather(
                timestamp: TimeInterval(forecastResponse.dt ?? 0),
                minTemp: Int(forecastResponse.main?.tempMin ?? 0),
                maxTemp: Int(forecastResponse.main?.tempMax ?? 0),
                windSpeed: forecastResponse.wind?.speed ?? 0,
                clouds: forecastResponse.clouds?.all ?? 0
            )
        } ?? []

        return DirtyForecast(weatherList: weatherList)
    }
}
