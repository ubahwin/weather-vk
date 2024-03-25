import UIKit

class ForcastWeatherCell: UITableViewCell {
    static let identifier = "ForcastWeatherCell"

    private let dayweek: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = ""
        label.font = .boldSystemFont(ofSize: 20)
        label.tintColor = .black
        return label
    }()

    private let temperature: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = ""
        label.font = .boldSystemFont(ofSize: 20)
        label.tintColor = .black
        return label
    }()

    private let clouds: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 14)
        label.tintColor = .black
        label.textAlignment = .center

        return label
    }()

    private let windSpeed: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 14)
        label.tintColor = .black
        label.textAlignment = .center

        return label
    }()

    private let cloudImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "cloud")
        image.tintColor = .black

        image.contentMode = .scaleAspectFit

        return image
    }()

    private let windImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "wind")
        image.tintColor = .black

        image.contentMode = .scaleAspectFit

        return image
    }()

    private func createVerticalStackView() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // swiftlint:disable line_length
    private func setupUI() {
        let windStackView = createVerticalStackView()
        windStackView.addArrangedSubview(windImage)
        windStackView.addArrangedSubview(windSpeed)

        let cloudsStackView = createVerticalStackView()
        cloudsStackView.addArrangedSubview(cloudImage)
        cloudsStackView.addArrangedSubview(clouds)

        self.contentView.addSubview(dayweek)
        self.contentView.addSubview(temperature)

        self.contentView.addSubview(windStackView)
        self.contentView.addSubview(cloudsStackView)

        dayweek.translatesAutoresizingMaskIntoConstraints = false
        temperature.translatesAutoresizingMaskIntoConstraints = false
        cloudsStackView.translatesAutoresizingMaskIntoConstraints = false
        windStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            dayweek.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            dayweek.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            dayweek.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),

            dayweek.widthAnchor.constraint(equalToConstant: 150),

            temperature.leadingAnchor.constraint(equalTo: windStackView.trailingAnchor, constant: 30),
            temperature.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            temperature.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            temperature.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),

            cloudsStackView.leadingAnchor.constraint(equalTo: self.dayweek.trailingAnchor),
            cloudsStackView.trailingAnchor.constraint(equalTo: windStackView.leadingAnchor),
            windStackView.leadingAnchor.constraint(equalTo: cloudsStackView.trailingAnchor),
            windStackView.trailingAnchor.constraint(equalTo: temperature.leadingAnchor),

            windStackView.widthAnchor.constraint(equalToConstant: 50),
            windStackView.heightAnchor.constraint(equalToConstant: 50),
            cloudsStackView.widthAnchor.constraint(equalToConstant: 50),
            cloudsStackView.heightAnchor.constraint(equalToConstant: 50),

            windStackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            cloudsStackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),

            self.contentView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    // swiftlint:enable line_length

    func configure(dayweek: DayWeek, weather: Weather) {
        self.dayweek.text = dayweek.title
        self.temperature.text = "\(weather.minTemp.description)° - \(weather.maxTemp.description)°"
        self.clouds.text = weather.clouds.description + "%"
        self.windSpeed.text = formatWind(weather.windSpeed) + " m/s"
    }

    private func formatWind(_ number: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 1
        return numberFormatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
}
