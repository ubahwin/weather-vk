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

        let vkuiMainView = VKUIMainView()
            .environment(\.weatherReducer, weatherReducer)
            .environmentObject(appState)
            .environment(\.colorScheme, .light)

        let forecastView = ForecastTable(appState: appState, weatherReducer: weatherReducer)

        let myMain = UIHostingController(rootView: mainView)
        myMain.tabBarItem.title = "Main"
        myMain.tabBarItem.image = UIImage(systemName: "cloud.sun")

        let vkuiMain = UIHostingController(rootView: vkuiMainView)
        vkuiMain.tabBarItem.title = "Main"
        vkuiMain.tabBarItem.image = UIImage(systemName: "cloud.sun")

        let vkuiUIKitMain = UINavigationController(rootViewController: MainViewController(
            appState: appState,
            weatherReducer: weatherReducer
        ))

        let forecast = UINavigationController(rootViewController: forecastView)
        forecast.tabBarItem.title = "Forecast"
        forecast.tabBarItem.image = UIImage(systemName: "table")
        forecast.navigationBar.topItem?.title = "Forecast"
        forecast.overrideUserInterfaceStyle = .light

        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([myMain, forecast], animated: true)
        tabBarController.tabBar.tintColor = .blue
        tabBarController.tabBar.unselectedItemTintColor = .black
        tabBarController.overrideUserInterfaceStyle = .light

        let window = UIWindow()

        // Подставьте сюда контроллер на свой выбор
        window.rootViewController = vkuiUIKitMain

        window.makeKeyAndVisible()
        self.window = window

        return true
    }
}
