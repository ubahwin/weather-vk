import UIKit
import SwiftUI

final class ForecastTable: UITableViewController {
    var appState: AppState
    var weatherReducer: IWeatherReducer

    private let cancelBag = CancelBag()

    init(appState: AppState, weatherReducer: WeatherReducer) {
        self.appState = appState
        self.weatherReducer = weatherReducer

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(ForcastWeatherCell.self, forCellReuseIdentifier: ForcastWeatherCell.identifier)

        weatherReducer.sinkToForecast(tableView.reloadData)
        weatherReducer.loadForecast()
    }

    override func numberOfSections(in tableView: UITableView) -> Int { 1 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        appState.forecast?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: ForcastWeatherCell.identifier, for: indexPath)

        guard let cell = cell as? ForcastWeatherCell else {
            fatalError("error in table view")
        }

        guard
            let date = self.appState.forecast?[indexPath.row].date,
            let weather = self.appState.forecast?[indexPath.row].weather
        else { return ForcastWeatherCell() }

        cell.backgroundColor = .white
        cell.configure(dayweek: date.dayOfWeek, weather: weather)
        cell.isUserInteractionEnabled = false

        return cell
    }
}
