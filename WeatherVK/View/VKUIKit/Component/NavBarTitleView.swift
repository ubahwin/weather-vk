import UIKit

class NavBarTitleView: UIView {
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        return label
    }()

    private var chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.tintColor = .systemGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var HStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(title: String) {
        titleLabel.text = title
    }

    private func configureView() {
        addSubview(HStack)
        HStack.addArrangedSubview(titleLabel)
        HStack.addArrangedSubview(chevronImageView)

        NSLayoutConstraint.activate([
            HStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            HStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            HStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            HStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),

            chevronImageView.heightAnchor.constraint(equalToConstant: 18),
            chevronImageView.widthAnchor.constraint(equalToConstant: 18)
        ])
    }
}
