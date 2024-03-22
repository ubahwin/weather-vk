import Foundation

class ForecastFormatter {
    private let calendar = Calendar.current

    func clean(dirtyForecast: DirtyForecast) -> [Forecast] {
        let list = dirtyForecast.weatherList

        if list.isEmpty { return [] }

        var forecasts = [Forecast]()
        var leftIndex = 0

        var leftDayWeek: DayWeek = .monday
        var rightDayWeek: DayWeek = .monday

        for rightIndex in 1..<list.count {
            leftDayWeek = calcDayWeek(utc: list[leftIndex].timeStamb)
            rightDayWeek = calcDayWeek(utc: list[rightIndex].timeStamb)

            if leftDayWeek != rightDayWeek {
                let dayWeekList = Array(list[leftIndex..<rightIndex])
                let weather: Weather = createAverageWeather(list: dayWeekList)

                forecasts.append(Forecast(
                    dayweek: calcDayWeek(utc: list[leftIndex].timeStamb),
                    wearher: weather
                ))

                leftIndex = rightIndex
            }
        }

        if forecasts.last?.dayweek != leftDayWeek {
            let dayWeekList = Array(list[leftIndex..<list.count])
            let weather: Weather = createAverageWeather(list: dayWeekList)

            forecasts.append(Forecast(
                dayweek: calcDayWeek(utc: list[leftIndex].timeStamb),
                wearher: weather
            ))
        }

        return forecasts
    }

    func createAverageWeather(list: [DirtyWeather]) -> Weather {
        var minTemp = Int.max
        var maxTemp = Int.min
        var windSpeed: Double = 0
        var clouds = 0

        for weather in list {
            minTemp = min(minTemp, Int(weather.minTemp))
            maxTemp = max(maxTemp, Int(weather.maxTemp))
        }

        windSpeed = list.reduce(0) { $0 + ($1.windSpeed) } / Double(list.count)
        clouds = list.reduce(0) { $0 + ($1.clouds) } / list.count

        return Weather(
            temperature: 0,
            minTemp: minTemp,
            maxTemp: maxTemp,
            windSpeed: windSpeed,
            windDirectDegrees: 0,
            clouds: clouds
        )
    }

    func calcDayWeek(utc: TimeInterval) -> DayWeek {
        let date = Date(timeIntervalSince1970: utc)
        let weekday = calendar.component(.weekday, from: date)
        return DayWeek(rawValue: weekday) ?? .friday
    }
}
