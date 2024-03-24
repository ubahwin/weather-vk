import UIKit

class TemperatureCell: UICollectionViewCell {
    static let reuseIdentifier = "TemperatureCell"

    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 60)
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
        addSubview(temperatureLabel)

        NSLayoutConstraint.activate([
            temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            temperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func configure(temperature: String?) {
        temperatureLabel.text = "\(temperature ?? "")°"
    }
}
