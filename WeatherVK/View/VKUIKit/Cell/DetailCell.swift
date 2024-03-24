import UIKit
import Foundation

class DetailCell: UICollectionViewCell {
    static let reuseIdentifier = "DetailCell"

    private var VStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    var windInfoView: DetailInfoView = {
        let detailInfoView = DetailInfoView()
        detailInfoView.titleLabel.text = "ветер"
        detailInfoView.imageView.image = UIImage(systemName: "wind")
        return detailInfoView
    }()

    let cloudInfoView: DetailInfoView = {
        let detailInfoView = DetailInfoView()
        detailInfoView.titleLabel.text = "облачность"
        detailInfoView.imageView.image = UIImage(systemName: "cloud")
        return detailInfoView
    }()

    let pressureInfoView: DetailInfoView = {
        let detailInfoView = DetailInfoView()
        detailInfoView.titleLabel.text = "давление"
        detailInfoView.imageView.image = UIImage(systemName: "tirepressure")
        return detailInfoView
    }()

    let visibilityInfoView: DetailInfoView = {
        let detailInfoView = DetailInfoView()
        detailInfoView.titleLabel.text = "видимость"
        detailInfoView.imageView.image = UIImage(systemName: "eye.circle")
        return detailInfoView
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
        VStack.addArrangedSubview(windInfoView)
        VStack.addArrangedSubview(cloudInfoView)
        VStack.addArrangedSubview(pressureInfoView)
        VStack.addArrangedSubview(visibilityInfoView)

        NSLayoutConstraint.activate([
            VStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            VStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            VStack.topAnchor.constraint(equalTo: topAnchor),
            VStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func configure(weather: Weather?) {
        guard let weather = weather else {
            return
        }
        windInfoView.infoLabel.text = (weather.windSpeed.description) + " м/с"
        cloudInfoView.infoLabel.text = (weather.clouds.description) + "%"
        pressureInfoView.infoLabel.text = (weather.pressureInMmHg.description) + " мм рт. ст."
        visibilityInfoView.infoLabel.text = weather.visibilityInKm.description + " км"
    }
}
