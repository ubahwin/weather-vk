import XCTest
@testable import WeatherVK

final class WeatherVKTests: XCTestCase {
    private let forecastFormat = ForecastFormatter()

    func test_forecastFormat_calcDayWeek_fromTimeStamp1() {
        let timeInt: TimeInterval = 1711022400
        XCTAssertEqual(
            forecastFormat.calcDayWeek(utc: timeInt),
            .thursday
        )
    }

    func test_forecastFormat_calcDayWeek_fromTimeStamp2() {
        let timeInt: TimeInterval = 1711054800
        XCTAssertEqual(
            forecastFormat.calcDayWeek(utc: timeInt),
            .friday
        )
    }

    func test_forecastFormat_calcDayWeek_fromTimeStamp3() {
        let timeInt: TimeInterval = 1711324800
        XCTAssertEqual(
            forecastFormat.calcDayWeek(utc: timeInt),
            .monday
        )
    }

    func test_forecastFormat_clean_empty() {
        let dirtyForecast = DirtyForecast(weatherList: [])

        XCTAssertEqual(
            forecastFormat.clean(dirtyForecast: dirtyForecast),
            []
        )
    }

    func test_forecastFormat_clean_thursdayAndMonday() {
        let timeIntMonday: TimeInterval = 1711324800
        let timeIntThursday: TimeInterval = 1711022400

        let weatherList = [
            DirtyWeather(
                timeStamb: timeIntMonday,
                minTemp: 1,
                maxTemp: 1,
                windSpeed: 1,
                clouds: 1
            ),
            DirtyWeather(
                timeStamb: timeIntMonday,
                minTemp: 1,
                maxTemp: 1,
                windSpeed: 1,
                clouds: 1
            ),
            DirtyWeather(
                timeStamb: timeIntMonday,
                minTemp: 1,
                maxTemp: 1,
                windSpeed: 1,
                clouds: 1
            ),
            DirtyWeather(
                timeStamb: timeIntMonday,
                minTemp: 1,
                maxTemp: 1,
                windSpeed: 1,
                clouds: 1
            ),
            DirtyWeather(
                timeStamb: timeIntThursday,
                minTemp: 2,
                maxTemp: 2,
                windSpeed: 2,
                clouds: 2
            ),
            DirtyWeather(
                timeStamb: timeIntThursday,
                minTemp: 2,
                maxTemp: 2,
                windSpeed: 2,
                clouds: 2
            )
        ]
        let dirtyForecast = DirtyForecast(weatherList: weatherList)

        XCTAssertEqual(
            forecastFormat.clean(dirtyForecast: dirtyForecast),
            [
                Forecast(
                    dayweek: .monday,
                    wearher: Weather(
                        temperature: 0,
                        minTemp: 1,
                        maxTemp: 1,
                        windSpeed: 1,
                        windDirectDegrees: 0,
                        clouds: 1
                    )
                ),
                Forecast(
                    dayweek: .thursday,
                    wearher: Weather(
                        temperature: 0,
                        minTemp: 2,
                        maxTemp: 2,
                        windSpeed: 2,
                        windDirectDegrees: 0,
                        clouds: 2
                    )
                )
            ]
        )
    }

    let createAverageWeatherList1 = [
        DirtyWeather(
            timeStamb: 1711324800,
            minTemp: 7,
            maxTemp: 4,
            windSpeed: 1,
            clouds: 0
        ),
        DirtyWeather(
            timeStamb: 1711324800,
            minTemp: 2,
            maxTemp: 9,
            windSpeed: 2,
            clouds: 0
        ),
        DirtyWeather(
            timeStamb: 1711324800,
            minTemp: 3,
            maxTemp: 2,
            windSpeed: 3,
            clouds: 0
        ),
        DirtyWeather(
            timeStamb: 1711324800,
            minTemp: -4,
            maxTemp: -1,
            windSpeed: 4,
            clouds: 100
        ),
        DirtyWeather(
            timeStamb: 1711324800,
            minTemp: 4,
            maxTemp: 10,
            windSpeed: 5,
            clouds: 100
        ),
        DirtyWeather(
            timeStamb: 1711324800,
            minTemp: 5,
            maxTemp: 1,
            windSpeed: 9,
            clouds: 100
        )
    ]

    func test_forecastFormat_createAverageWeather_1() {
        XCTAssertEqual(
            forecastFormat.createAverageWeather(list: createAverageWeatherList1),
            Weather(
                temperature: 0,
                minTemp: -4,
                maxTemp: 10,
                windSpeed: 4,
                windDirectDegrees: 0,
                clouds: 50
            )
        )
    }

}

extension Forecast: Equatable {
    public static func == (lhs: WeatherVK.Forecast, rhs: WeatherVK.Forecast) -> Bool {
        lhs.dayweek == rhs.dayweek && lhs.wearher == rhs.wearher
    }
}

extension Weather: Equatable {
    public static func == (lhs: Weather, rhs: Weather) -> Bool {
        lhs.temperature == rhs.temperature &&
        lhs.minTemp == rhs.minTemp &&
        lhs.maxTemp == rhs.maxTemp &&
        lhs.windSpeed == rhs.windSpeed &&
        lhs.windDirectDegrees == rhs.windDirectDegrees &&
        lhs.clouds == rhs.clouds
    }
}
