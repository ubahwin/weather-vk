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

        let main = UIHostingController(rootView: mainView)
        main.tabBarItem.title = "Main"
        main.tabBarItem.image = UIImage(systemName: "cloud.sun")
        main.navigationItem.title = "Weather"

        let cities = UINavigationController(rootViewController: CitiesTable())
        cities.tabBarItem.title = "Cities"
        cities.tabBarItem.image = UIImage(systemName: "house")

        UITabBar.appearance().barTintColor = .white

        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([main, cities], animated: true)
        tabBarController.tabBar.tintColor = .cyan
        tabBarController.tabBar.unselectedItemTintColor = .black

        let window = UIWindow()
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()

        self.window = window

        return true
    }
}
