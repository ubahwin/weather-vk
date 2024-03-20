import SwiftUI

struct MainView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.weatherReducer) private var weatherReducer: WeatherReducer

    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()

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

            Cloud(width: 140, height: 80) {
                Text("\(appState.currentWeather?.temperature.description ?? "") °C")
            }
        }
        .onAppear {
            weatherReducer.loadWeather()
        }
    }
}

struct Preview: PreviewProvider {
    static var previews: some View {
        MainView()
            .environment(\.weatherReducer, WeatherReducer.stub)
            .environmentObject(AppState())
    }
}
