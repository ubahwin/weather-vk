import SwiftUI

struct ForecastCell: View {
    var forecast: Forecast

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(forecast.date.dayOfWeek.titleVKUI)
                    .foregroundStyle(forecast.date.dayOfWeek.isWeekend ? Color(hex: 0xE64646) : .black)
                Text(forecast.date.title)
                    .foregroundStyle(.gray)
                    .font(.footnote)
            }
            Spacer()
            Text(forecast.weather.type.image)
                .frame(width: 50, alignment: .trailing)
            Text("\(forecast.weather.maxTemp)°")
                .frame(width: 50, alignment: .trailing)
                .bold()
            Text("\(forecast.weather.minTemp)°")
                .frame(width: 50, alignment: .trailing)
                .bold()
                .foregroundStyle(Color(hex: 0x76787A))
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

#Preview {
    ForecastCell(forecast: Forecast(
        date: .now,
        weather: Weather(
            type: .clouds,
            temperature: 1,
            minTemp: -11,
            maxTemp: 12,
            windSpeed: 1,
            windDirectDegrees: 1,
            clouds: 1,
            pressure: 1,
            visibility: 1
        ))
    )
}
