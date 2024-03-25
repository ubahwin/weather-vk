import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // MARK: Assembly modules

        let appState = AppState()
        let weatherReducer = WeatherReducer(
            appState: appState,
            weatherWebRepository: OpenWeatherWebRepository(),
            locationManager: LocationManager()
        )

        // MARK: Old degign

        let oldMainView = MainView()
            .environment(\.weatherReducer, weatherReducer)
            .environmentObject(appState)
            .environment(\.colorScheme, .light)

        let forecastView = ForecastTable(appState: appState, weatherReducer: weatherReducer)

        let oldMainController = UIHostingController(rootView: oldMainView)
        oldMainController.tabBarItem.title = "Main"
        oldMainController.tabBarItem.image = UIImage(systemName: "cloud.sun")

        let oldForecastControler = UINavigationController(rootViewController: forecastView)
        oldForecastControler.tabBarItem.title = "Forecast"
        oldForecastControler.tabBarItem.image = UIImage(systemName: "table")
        oldForecastControler.navigationBar.topItem?.title = "Forecast"
        oldForecastControler.overrideUserInterfaceStyle = .light

        let oldTabBarController = UITabBarController()
        oldTabBarController.setViewControllers([oldMainController, oldForecastControler], animated: true)
        oldTabBarController.tabBar.tintColor = .blue
        oldTabBarController.tabBar.unselectedItemTintColor = .black
        oldTabBarController.overrideUserInterfaceStyle = .light

        // MARK: SwiftUI

        let SwiftUI_VKUIController = UIHostingController(rootView: VKUIMainView()
            .environment(\.weatherReducer, weatherReducer)
            .environmentObject(appState)
            .environment(\.colorScheme, .light)
        )

        // MARK: UIKit

        let UIKit_VKUIController = UINavigationController(rootViewController: MainViewController(
            appState: appState,
            weatherReducer: weatherReducer
        ))

        let window = UIWindow()

        /*

         Подставьте сюда контроллер на свой выбор:

         1. SwiftUI_VKUIController
         2. UIKit_VKUIController
         3. oldTabBarController

        */
        window.rootViewController = SwiftUI_VKUIController

        window.makeKeyAndVisible()
        self.window = window

        return true
    }
}
