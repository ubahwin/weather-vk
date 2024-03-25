import UIKit

final class UserLocationCell: UITableViewCell {
    static let reuseIdentifier = "UserLocationCell"

    private let detailInfoView: DetailInfoView = {
        let detail = DetailInfoView()
        detail.imageView.image = UIImage(systemName: "location")
        detail.imageView.tintColor = .blue
        detail.titleLabel.font = .systemFont(ofSize: 17)
        detail.titleLabel.textColor = .black
        detail.titleLabel.text = "Моё местоположение"
        detail.infoLabel.font = .systemFont(ofSize: 14)
        detail.infoLabel.textColor = .systemGray
        detail.infoLabel.text = "Точный прогноз"
        detail.translatesAutoresizingMaskIntoConstraints = false
        return detail
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureCell() {
        addSubview(detailInfoView)

        NSLayoutConstraint.activate([
            detailInfoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            detailInfoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            detailInfoView.topAnchor.constraint(equalTo: topAnchor),
            detailInfoView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
