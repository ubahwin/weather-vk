import UIKit

final class CitySearchViewController: UIViewController {
    var appState: AppState
    var weatherReducer: WeatherReducer
    private let cancelBag = CancelBag()

    private lazy var citySearchView = CitySearchView()
    private let searchController = UISearchController()
    private var sections: [Section] = [.location, .searchResult]

    enum Section: String, CaseIterable {
        case location, searchResult
    }

    init(appState: AppState, weatherReducer: WeatherReducer) {
        self.appState = appState
        self.weatherReducer = weatherReducer

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = citySearchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        setupTableView()
        setupNavBar()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        searchController.dismiss(animated: false)
    }

    private func setupSearchController() {
        searchController.searchBar.tintColor = .gray
        searchController.searchBar.delegate = self
    }

    private func setupNavBar() {
        title = "Регион"
        searchController.searchBar.searchTextField.addTarget(
            self,
            action: #selector(searchFieldDidFinishEditing),
            for: .editingDidEndOnExit
        )
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        navigationItem.titleView?.tintColor = .black
        navigationItem.searchController = searchController
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark.circle.fill"),
            style: .plain,
            target: self,
            action: #selector(didTapCloseButton)
        )
        navigationItem.rightBarButtonItem?.tintColor = .gray
    }

    private func setupTableView() {
        citySearchView.tableView.dataSource = self
        citySearchView.tableView.delegate = self
        citySearchView.tableView.backgroundColor = .white
        citySearchView.tableView.separatorStyle = .none
        citySearchView.tableView.register(
            LocationSearchCell.self,
            forCellReuseIdentifier: LocationSearchCell.reuseIdentifier
        )
        citySearchView.tableView.register(
            UserLocationCell.self,
            forCellReuseIdentifier: UserLocationCell.reuseIdentifier
        )
    }

    @objc private func didTapCloseButton() {
        navigationController?.dismiss(animated: true)
    }

    @objc func searchFieldDidFinishEditing() {
        weatherReducer.loadCity(from: searchController.searchBar.text ?? "")
    }
}

extension CitySearchViewController: UITableViewDataSource {
    private func numberOfRows(for section: Section) -> Int {
        appState.cityList.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows(for: sections[section])
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .location:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: UserLocationCell.reuseIdentifier
            ) as? UserLocationCell else { fatalError() }

            return cell
        case .searchResult:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: LocationSearchCell.reuseIdentifier
            ) as? LocationSearchCell else { fatalError() }

            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension CitySearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch sections[indexPath.section] {
//        case .location:
//            let cell = tableView.cellForRow(at: indexPath) as! UserLocationCell
//        case .searchResult:
//            let cell = tableView.cellForRow(at: indexPath) as! LocationSearchCell
//            searchController.searchBar.resignFirstResponder()
//        }
    }

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 60 }
}

extension CitySearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        citySearchView.tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        citySearchView.tableView.reloadData()
    }
}
