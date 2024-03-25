import UIKit

class SectionBackgroundView: UICollectionReusableView {
    static let kindIdenifier = "SectionBackgroundView"

    override func didMoveToSuperview() {
        backgroundColor = .white
        layer.shadowRadius = 10
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
    }
}
