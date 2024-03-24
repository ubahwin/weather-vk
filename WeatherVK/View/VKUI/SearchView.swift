import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.weatherReducer) private var weatherReducer: WeatherReducer

    @Binding var isOpen: Bool

    @State private var citySearch = ""

    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    Text("Регион")

                    HStack {
                        Spacer()
                        Button {
                            isOpen = false
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(Color(hex: 0xEBEDF0))
                                    .frame(width: 30, height: 30)
                                Image(systemName: "xmark")
                                    .foregroundStyle(Color(hex: 0x7F8285))
                            }
                        }
                        .padding(.trailing, 20)
                    }
                }
                .padding(.top, 20)

                TextField("Поиск", text: $citySearch) {
                    weatherReducer.loadCity(from: citySearch)
                }
                    .textFieldStyle(VKUITextFieldStyle())
                    .padding()

                ScrollView {
                    Button {
                        isOpen = false
                        weatherReducer.loadCurrentCity()
                    } label: {
                        HStack {
                            HStack {
                                Image(systemName: "location")
                                    .frame(width: 40)
                                    .foregroundStyle(Color(hex: 0x2D81E0))
                                VStack(alignment: .leading) {
                                    Text("Моё местоположение")
                                        .foregroundStyle(.black)
                                    Text("Точный прогноз")
                                        .font(.footnote)
                                        .foregroundStyle(.gray)
                                }
                            }
                            .padding(.horizontal)
                            Spacer()
                        }
                    }

                    SmallLine()
                    .padding(.vertical, 20)

                    ForEach(appState.cityList, id: \.name) { city in
                        Button {
                            isOpen = false
                            appState.currentCity = city
                            weatherReducer.loadForecast()
                            weatherReducer.loadWeather()
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(city.name)
                                        .foregroundStyle(.black)
                                    Text("Город")
                                        .font(.footnote)
                                        .foregroundStyle(.gray)
                                }
                                .padding(.horizontal)
                                Spacer()
                            }

                        }
                                          
                    }
                }
            }

            ZStack {
                VStack {
                    Spacer()
                    Color(hex: 0xEBEDF0)
                        .ignoresSafeArea()
                        .frame(height: 100)
                }

                VStack {
                    Spacer()
                    Button("Готово") {
                        isOpen = false
                    }
                    .buttonStyle(VKUIButtonStyle())
                }
            }
        }
    }
}

#Preview {
    SearchView(isOpen: .constant(true))
        .environment(\.weatherReducer, WeatherReducer.stub)
        .environmentObject(AppState())
        .preferredColorScheme(.light)
}
