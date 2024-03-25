import SwiftUI
import UIKit

struct VKUIMainView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.weatherReducer) private var weatherReducer: WeatherReducer

    @State private var openSearch = false

    private let mockData: [Forecast] = [.stub, .stub, .stub, .stub, .stub]

    private let themeDayColors: ColorPair = ColorPair(.white, .blue)
    private let themeNightColors: ColorPair = ColorPair(Color(hex: 0x0009c0), Color(hex: 0x040d46))
    private let now = Date()

    var body: some View {
        ZStack {
            Color(hex: 0xebedf0).ignoresSafeArea()

            ScrollView {
                VStack {
                    ZStack {
                        if appState.currentWeather == nil {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color(hex: 0xE1E3E6))
                                .frame(width: 300, height: 150)
                        } else {
                            Theme(
                                weatherType: appState.currentWeather?.type ?? .clearSky,
                                date: now,
                                dayColors: themeDayColors,
                                nightColors: themeNightColors
                            )

                            Text("\(appState.currentWeather?.temperature ?? 0)°")
                                .font(.system(size: 80))
                                .bold()
                                .foregroundStyle(themeNightColors.calculateContrastColor())
                                .shadow(color: Color(hex: 0x070820, alpha: now.isDaytime ? 0.1 : 1), radius: 5)
                        }
                    }

                    HStack {
                        Text("Сейчас на улице")
                            .bold()
                            .padding()
                        Spacer()
                    }

                    VStack {
                        HStack {
                            Image(systemName: "wind")
                                .frame(width: 30)

                            VStack(alignment: .leading) {
                                Text("ветер")
                                    .foregroundStyle(.gray)
                                    .font(.footnote)
                                Text("\(appState.currentWeather?.windSpeed.formatted() ?? "0") м/с")
                            }

                            Spacer()
                        }
                        .padding(.horizontal)

                        HStack {
                            Image(systemName: "cloud")
                                .frame(width: 30, height: 30)

                            VStack(alignment: .leading) {
                                Text("облачность")
                                    .foregroundStyle(.gray)
                                    .font(.footnote)
                                Text("\(appState.currentWeather?.clouds ?? 0)%")
                            }

                            Spacer()
                        }
                        .padding(.horizontal)

                        HStack {
                            Image(systemName: "fitness.timer")
                                .frame(width: 30, height: 30)

                            VStack(alignment: .leading) {
                                Text("давление")
                                    .foregroundStyle(.gray)
                                    .font(.footnote)
                                Text("\(appState.currentWeather?.pressureInMmHg ?? 0) мм рт. ст.")
                            }

                            Spacer()
                        }
                        .padding(.horizontal)

                        HStack {
                            Image(systemName: "eye.circle")
                                .frame(width: 30, height: 30)

                            VStack(alignment: .leading) {
                                Text("видимость")
                                    .foregroundStyle(.gray)
                                    .font(.footnote)
                                Text("\(appState.currentWeather?.visibilityInKm ?? 0) км")
                            }

                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    .redacted(reason: appState.currentWeather == nil ? .placeholder : .init())

                    SmallLine()
                        .padding(.top)

                    HStack {
                        Text("Прогноз погоды")
                            .bold()
                            .padding()
                        Spacer()
                    }

                    if appState.forecast == nil {
                        ForEach(mockData, id: \.date) {
                            ForecastCell(forecast: $0)
                        }
                        .redacted(reason: appState.currentWeather == nil ? .placeholder : .init())
                    } else {
                        ForEach(appState.forecast ?? [], id: \.date) {
                            ForecastCell(forecast: $0)
                        }
                    }
                }
                .padding(.top, 80)
            }

            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color(hex: 0xE1E3E6))
                        .frame(height: UIDevice.current.hasDynamicIsland ? 100 : 60)
                    HStack {
                        Text(appState.currentCity?.name ?? "Поиск...")
                            .bold()
                            .font(.title3)
                        Button {
                            openSearch = true
                        } label: {
                            Image(systemName: "chevron.down")
                                .foregroundStyle(.black)
                        }
                    }
                    .padding(.top, UIDevice.current.hasDynamicIsland ? 50 : 15)
                }
                .ignoresSafeArea()

                Spacer()
            }
        }
        .onAppear {
            weatherReducer.loadWeather()
            weatherReducer.loadForecast()
        }
        .sheet(isPresented: $openSearch) {
            SearchView(isOpen: $openSearch)
                .preferredColorScheme(.light)
        }
    }
}

#Preview {
    VKUIMainView()
        .environment(\.weatherReducer, WeatherReducer.stub)
        .environmentObject(AppState())
}
