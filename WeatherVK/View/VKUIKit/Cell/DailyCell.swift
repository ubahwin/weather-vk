import UIKit

class DailyCell: UICollectionViewCell {
    static let reuseIdentifier = "DailyCell"

    private var VStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var HStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 24
        stackView.distribution = .equalCentering
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let dayWeekLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let minTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        label.textAlignment = .right
        return label
    }()

    let maxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
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
        addSubview(VStack)
        addSubview(HStack)
        VStack.addArrangedSubview(dayWeekLabel)
        VStack.addArrangedSubview(dateLabel)
        HStack.addArrangedSubview(maxTemperatureLabel)
        HStack.addArrangedSubview(minTemperatureLabel)

        NSLayoutConstraint.activate([
            minTemperatureLabel.widthAnchor.constraint(equalToConstant: 35),
            maxTemperatureLabel.widthAnchor.constraint(equalToConstant: 35),

            VStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            VStack.centerYAnchor.constraint(equalTo: centerYAnchor),

            HStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            HStack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func configure(forecast: Forecast?) {
        dayWeekLabel.text = forecast?.date.dayOfWeek.titleVKUI
        dayWeekLabel.textColor = forecast?.date.dayOfWeek.isWeekend ?? false ? .red : .black
        dateLabel.text = forecast?.date.title
        maxTemperatureLabel.text = "\(forecast?.weather.maxTemp.description ?? "")°"
        minTemperatureLabel.text = "\(forecast?.weather.minTemp.description ?? "")°"
    }
}
