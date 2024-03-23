import SwiftUI
import MapKit
import Combine

struct MainView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.weatherReducer) private var weatherReducer: WeatherReducer

    @State private var openSearch = false
    @State private var citySearch = ""
    @FocusState private var focused: Bool

    @State private var keyboardHeight: CGFloat = 0

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: .init(colors: [.blue, .white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ZStack {
                VStack {
                    HStack {
                        if !openSearch {
                            Cloud(width: 50, height: 50) {
                                Button(action: {
                                    weatherReducer.reloadData()
                                }, label: {
                                    Image(systemName: "arrow.clockwise")
                                        .foregroundStyle(.black)
                                })
                            }
                            .padding()

                            Spacer()

                            Text(appState.currentCity?.name ?? "Поиск...")
                                .font(.title)
                                .padding(.top)
                                .frame(width: 200)
                                .foregroundStyle(.yellow)

                            Spacer()
                        }

                        Cloud(width: openSearch ? 350 : 50, height: 50) {
                            if openSearch {
                                TextField("Введите город", text: $citySearch)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .focused($focused, equals: true)
                                    .padding()
                            } else {
                                Button(action: {
                                    focused = true
                                    withAnimation(.easeOut) {
                                        openSearch = true
                                    }
                                }, label: {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundStyle(.black)
                                })
                            }
                        }
                        .padding()
                    }
                    Spacer()
                }
            }

            VStack {
                Cloud(width: 120, height: 80, moveRetio: 8) {
                    Text("\(appState.currentWeather?.temperature.description ?? "") °C")
                        .font(.title)
                        .bold()
                }
                .padding(20)

                Cloud(width: 100, height: 70, moveRetio: 10) {
                    HStack {
                        Image(systemName: "arrow.up")
                            .rotationEffect(.degrees(
                                (appState.currentWeather?.windDirectDegrees ?? 0) - appState.phoneRotateDegrees
                            ))
                        Text("\(appState.currentWeather?.windSpeed.description ?? "") m/s")
                    }
                }

                Cloud(width: 100, height: 70, moveRetio: 10) {
                    HStack {
                        Image(systemName: "cloud")
                        Text("\(appState.currentWeather?.clouds.description ?? "") %")
                    }
                }
            }
            .offset(y: keyboardHeight)

            if openSearch {
                CitySearch(isOpen: $openSearch, keyboardHeight: $keyboardHeight) {
                    VStack {
                        ForEach(appState.cityList, id: \.name) { city in
                            Button {
                                openSearch = false

                                appState.currentCity = city
                                weatherReducer.loadWeather()
                            } label: {
                                Text(city.name)
                                    .padding()
                            }
                        }
                        Spacer()
                    }
                    .padding(.top)
                }
            }
        }
        .onAppear {
            weatherReducer.loadWeather()
            weatherReducer.loadForecast()
        }
        .onChange(of: citySearch) {
            weatherReducer.loadCity(from: $0)
        }
        .onReceive(Publishers.keyboardHeight) { keyboardHeight in
            self.keyboardHeight = keyboardHeight
        }
    }
}

struct Preview: PreviewProvider {
    static var previews: some View {
        MainView()
            .environment(\.weatherReducer, WeatherReducer.stub)
            .environmentObject(AppState())
            .environment(\.colorScheme, .light)
    }
}
