import SwiftUI

struct VKUIMainView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.weatherReducer) private var weatherReducer: WeatherReducer

    @State private var openSearch = false

    var body: some View {
        ZStack {
            Color(hex: 0xEBEDF0).ignoresSafeArea()

            ScrollView {
                VStack {
                    Text("\(appState.currentWeather?.temperature ?? 0)°")
                        .font(.system(size: 50))

                    SmallLine()

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
                                Text("\(appState.currentWeather?.pressure ?? 0) мм рт. ст.")
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
                                Text("\(appState.currentWeather?.visibility ?? 0) м")
                            }

                            Spacer()
                        }
                        .padding(.horizontal)
                    }

                    SmallLine()
                        .padding(.top)

                    HStack {
                        Text("Прогноз погоды")
                            .bold()
                            .padding()
                        Spacer()
                    }

                    ForEach(appState.forecast ?? [], id: \.date) { forecast in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(forecast.date.dayOfWeek.title)
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
                                .bold()
                                .foregroundStyle(Color(hex: 0x76787A))
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    }
                }
                .padding(.top, 80)
            }

            VStack{
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
