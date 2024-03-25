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
        let type = mostCommonWeatherType(list.map { $0.type })

        return Weather(
            type: type,
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

    func mostCommonWeatherType(_ weatherTypes: [WeatherType]) -> WeatherType {
        var dict = [WeatherType: Int]()

        for weatherType in weatherTypes {
            if dict[weatherType] != nil {
                dict[weatherType]! += 1
            } else {
                dict[weatherType] = 1
            }
        }

        var maxCount = 0
        var curType: WeatherType = weatherTypes.first!

        for (type, count) in dict where count > maxCount {
            maxCount = count
            curType = type
        }

        return curType
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

        var title = Date.dateFormatter.string(from: self).lowercased()

        if self.isToday() {
            title += ", сегодня"
        }

        return title
    }

    var isDaytime: Bool {
        let hour = Calendar.current.component(.hour, from: self)
        return hour >= 6 && hour < 21
    }

    func isSameDay(with: Date) -> Bool {
        let cur = Calendar.current.dateComponents([.day, .month, .year], from: self)
        let now = Calendar.current.dateComponents([.day, .month, .year], from: with)
        return cur == now
    }

    func isToday() -> Bool {
        isSameDay(with: Date.now)
    }
}
