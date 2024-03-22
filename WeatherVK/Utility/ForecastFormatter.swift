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
            leftDayWeek = calcDayWeek(utc: list[leftIndex].timestamp)
            rightDayWeek = calcDayWeek(utc: list[rightIndex].timestamp)

            if leftDayWeek == rightDayWeek && rightIndex != list.count - 1 {
                continue
            }

            let forecast = Forecast(
                dayweek: calcDayWeek(utc: list[leftIndex].timestamp),
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
