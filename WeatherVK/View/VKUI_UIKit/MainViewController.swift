import UIKit

final class MainViewController: UIViewController {
    var appState: AppState
    var weatherReducer: WeatherReducer
    private let cancelBag = CancelBag()

    private let navBarTitleView = NavBarTitleView()
    private lazy var weatherView = WeatherView()

    private var sections: [Section] = [.main, .detail, .forecast]

    enum Section: CaseIterable {
        case main
        case detail
        case forecast
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
        view = weatherView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        setupNavTitle()

        weatherReducer.reloadData()

        weatherReducer.sinkToAllData { [self] in
            self.weatherView.collectionView.reloadData()
            navBarTitleView.configure(title: appState.currentCity?.name ?? "Поиск...")
        }

        weatherReducer.reloadData()
    }

    private func setupNavTitle() {
        navBarTitleView.configure(title: appState.currentCity?.name ?? "Поиск...")
        navigationItem.titleView = navBarTitleView
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapNavBarTitleView))
        navBarTitleView.addGestureRecognizer(tap)
    }

    @objc private func didTapNavBarTitleView() {
        let citySearchController = CitySearchViewController(appState: appState, weatherReducer: weatherReducer)
        let nav = UINavigationController(rootViewController: citySearchController)
        present(nav, animated: true)
    }

    private func setupCollectionView() {
        weatherView.collectionView.setCollectionViewLayout(createLayout(), animated: true)
        weatherView.collectionView.dataSource = self
        weatherView.collectionView.delegate = self

        weatherView.collectionView.register(
            DailyCell.self,
            forCellWithReuseIdentifier: DailyCell.reuseIdentifier
        )
        weatherView.collectionView.register(
            DetailCell.self,
            forCellWithReuseIdentifier: DetailCell.reuseIdentifier
        )
        weatherView.collectionView.register(
            TemperatureCell.self,
            forCellWithReuseIdentifier: TemperatureCell.reuseIdentifier
        )
        weatherView.collectionView.register(
            CollectionViewHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CollectionViewHeader.reuseIdentifier
        )
    }
}

extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        switch sections[section] {
        case .forecast:
            return appState.forecast?.count ?? 0
        default: return 1
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .main:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TemperatureCell.reuseIdentifier,
                for: indexPath
            ) as? TemperatureCell else { fatalError() }

            cell.configure(temperature: appState.currentWeather?.temperature.description)

            return cell
        case .detail:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DetailCell.reuseIdentifier,
                for: indexPath
            ) as? DetailCell else { fatalError() }

            cell.configure(weather: appState.currentWeather)

            return cell
        case .forecast:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DailyCell.reuseIdentifier,
                for: indexPath
            ) as? DailyCell else { fatalError() }

            cell.configure(forecast: appState.forecast?[indexPath.row])

            return cell
        }
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CollectionViewHeader.reuseIdentifier,
            for: indexPath
        ) as? CollectionViewHeader else { fatalError() }

        header.label.font = .systemFont(ofSize: 18, weight: .semibold)

        switch Section.allCases[indexPath.section] {
        case .detail:
            header.label.text = "Сейчас на улице"
        case .forecast:
            header.label.text = "Прогноз погоды"
        case .main:
            break
        }

        return header
    }
}
