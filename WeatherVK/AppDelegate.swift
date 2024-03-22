import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let appState = AppState()
        let weatherReducer = WeatherReducer(
            appState: appState,
            weatherWebRepository: OpenWeatherWebRepository(),
            locationManager: LocationManager()
        )

        let mainView = MainView()
            .environment(\.weatherReducer, weatherReducer)
            .environmentObject(appState)
            .environment(\.colorScheme, .light)

        let forecastView = ForecastTable(appState: appState, weatherReducer: weatherReducer)

        let main = UIHostingController(rootView: mainView)
        main.tabBarItem.title = "Main"
        main.tabBarItem.image = UIImage(systemName: "cloud.sun")

        let forecast = UINavigationController(rootViewController: forecastView)
        forecast.tabBarItem.title = "Forecast"
        forecast.tabBarItem.image = UIImage(systemName: "table")
        forecast.navigationBar.topItem?.title = "Forecast"
        forecast.overrideUserInterfaceStyle = .light

        UITabBar.appearance().barTintColor = .white
        UINavigationBar.appearance().barTintColor = .white
        UITableView.appearance().tintColor = .white

        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([main, forecast], animated: true)
        tabBarController.tabBar.tintColor = .blue
        tabBarController.tabBar.unselectedItemTintColor = .black
        tabBarController.overrideUserInterfaceStyle = .light

        let window = UIWindow()
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()

        self.window = window

        return true
    }
}
