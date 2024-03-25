import Foundation

class ForecastFormatter {
    func clean(dirtyForecast: DirtyForecast) -> [Forecast] {
        let list = dirtyForecast.weatherList

        if list.isEmpty { return [] }

        var forecasts = [Forecast]()
        var leftIndex = 0

        var leftDayWeek: DayWeek = .monday
        var rightDayWeek: DayWeek = .monday

        for rightIndex in 1..<list.count {
            leftDayWeek = Date(timeIntervalSince1970: list[leftIndex].timestamp).dayOfWeek
            rightDayWeek = Date(timeIntervalSince1970: list[rightIndex].timestamp).dayOfWeek

            if leftDayWeek == rightDayWeek && rightIndex != list.count - 1 {
                continue
            }

            let forecast = Forecast(
                date: Date(timeIntervalSince1970: list[leftIndex].timestamp),
                weather: createAverageWeather(list: Array(list[leftIndex..<rightIndex]))
            )

            forecasts.append(forecast)

            leftIndex = rightIndex
        }

        return forecasts
    }

    func createAverageWeather(list: [DirtyWeather]) -> Weather {
        var minTemp = list[0].minTemp
        var maxTemp = list[0].maxTemp

        for index in 1..<list.count {
            minTemp = min(minTemp, list[index].minTemp)
            maxTemp = max(maxTemp, list[index].maxTemp)
        }

        let windSpeed = list.reduce(0) { $0 + ($1.windSpeed) } / Double(list.count)
        let clouds = list.reduce(0) { $0 + ($1.clouds) } / list.count

        return Weather(
            type: .clearSky,
            temperature: 0,
            minTemp: minTemp,
            maxTemp: maxTemp,
            windSpeed: windSpeed,
            windDirectDegrees: 0,
            clouds: clouds,
            pressure: 0,
            visibility: 0
        )
    }
}

extension Date {
    private static let dateFormatter = DateFormatter()

    var dayOfWeek: DayWeek {
        let weekday = Calendar.current.component(.weekday, from: self)
        return DayWeek(rawValue: weekday) ?? .friday
    }

    var title: String {
        Date.dateFormatter.dateFormat = "dd MMMM"
        Date.dateFormatter.locale = Locale(identifier: "ru_RU")
        return Date.dateFormatter.string(from: self).lowercased()
    }

    var isDaytime: Bool {
        let hour = Calendar.current.component(.hour, from: self)
        return hour >= 6 && hour < 21
    }
}
