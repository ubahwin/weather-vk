import UIKit
import SwiftUI

class ForecastTable: UITableViewController {
    var appState: AppState
    var weatherReducer: WeatherReducer

    private let cancelBag = CancelBag()

    init(appState: AppState, weatherReducer: WeatherReducer) {
        self.appState = appState
        self.weatherReducer = weatherReducer

        weatherReducer.loadForecast()

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        weatherReducer.sinkToData(tableView.reloadData)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appState.forecast?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = appState.forecast?[indexPath.row].temperature.description
        return cell
    }
}
