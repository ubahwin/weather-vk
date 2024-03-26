import UIKit

final class DailyCell: UICollectionViewCell {
    static let reuseIdentifier = "DailyCell"

    private var vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 24
        stackView.distribution = .equalCentering
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let dayWeekLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let minTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .gray
        label.textAlignment = .right
        return label
    }()

    private let maxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()

    private let weatherTypeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureCell() {
        addSubview(vStackView)
        addSubview(hStackView)
        vStackView.addArrangedSubview(dayWeekLabel)
        vStackView.addArrangedSubview(dateLabel)
        hStackView.addArrangedSubview(weatherTypeLabel)
        hStackView.addArrangedSubview(maxTemperatureLabel)
        hStackView.addArrangedSubview(minTemperatureLabel)

        NSLayoutConstraint.activate([
            minTemperatureLabel.widthAnchor.constraint(equalToConstant: 35),
            maxTemperatureLabel.widthAnchor.constraint(equalToConstant: 35),

            vStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStackView.centerYAnchor.constraint(equalTo: centerYAnchor),

            hStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            hStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func configure(forecast: Forecast?) {
        dayWeekLabel.text = forecast?.date.dayOfWeek.titleVKUI
        dayWeekLabel.textColor = forecast?.date.dayOfWeek.isWeekend ?? false ? .red : .black
        dateLabel.text = forecast?.date.title
        maxTemperatureLabel.text = "\(forecast?.weather.maxTemp.description ?? "")°"
        minTemperatureLabel.text = "\(forecast?.weather.minTemp.description ?? "")°"
        weatherTypeLabel.text = forecast?.weather.type.image
    }
}
