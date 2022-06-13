import UIKit

final class FeatureToggleTagCell: UICollectionViewCell {
   
    var currentBackgroundColor: UIColor? {
        didSet {
            guard currentBackgroundColor != oldValue, !isSelected else { return }
            backgroundColor = currentBackgroundColor
        }
    }
    
    override var isSelected: Bool {
        didSet {
            guard isSelected != oldValue else { return }
            backgroundColor = isSelected ? .black : currentBackgroundColor
            titleLabel.textColor = .white
        }
    }
    
    private let titleLabel = UILabel()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = bounds
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return titleLabel.sizeThatFits(size)
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    // MARK: - Private methods
    private func commonInit() {
        layer.cornerRadius = 5
        clipsToBounds = true
        
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
    }
    
}
