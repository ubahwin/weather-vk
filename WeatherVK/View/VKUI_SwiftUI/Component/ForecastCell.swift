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
            Text("\(forecast.weather.maxTemp)°")
                .frame(width: 60)
                .bold()
            Text("\(forecast.weather.minTemp)°")
                .padding(.leading)
                .bold()
                .foregroundStyle(Color(hex: 0x76787A))
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}
