import SwiftUI

struct MainView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.weatherReducer) private var weatherReducer: WeatherReducer

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
                        Spacer()
                        Cloud(width: 50, height: 50) {
                            Button(action: weatherReducer.loadWeather, label: {
                                Image(systemName: "arrow.clockwise")
                                    .foregroundStyle(.black)
                            })
                        }
                        .padding()
                    }
                    Spacer()
                }
            }

            VStack {
                Cloud(width: 120, height: 80) {
                    Text("\(appState.currentWeather?.temperature.description ?? "") °C")
                        .font(.title)
                        .bold()
                }
                Cloud(width: 100, height: 70) {
                    HStack {
                        Image(systemName: "arrow.up")
                            .rotationEffect(.degrees(
                                (appState.currentWeather?.windDirectDegrees ?? 0) - appState.phoneRotateDegrees
                            ))
                        Text("\(appState.currentWeather?.windSpeed.description ?? "") m/s")
                    }
                }
                Cloud(width: 100, height: 70) {
                    HStack {
                        Image(systemName: "cloud")
                        Text("\(appState.currentWeather?.clouds.description ?? "") %")
                    }
                }
            }
        }
        .onAppear {
            weatherReducer.loadWeather()
        }
        .onReceive(appState.$phoneRotateDegrees) { rot in
            print(rot)
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
