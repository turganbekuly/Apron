import APRUIKit
import UIKit

public final class SearchResultNotFoundCell: UITableViewCell {

    // MARK: - Views

    private lazy var iconImageView: UIImageView = {
        let view = UIImageView(image: APRAssets.navSearchIcon.image)
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ничего не найдено"
        return label
    }()

    // MARK: - Init

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureViews()
    }

    public required init?(coder: NSCoder) {
        nil
    }

    // MARK: - Life Cycle

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureColors()
    }

    // MARK: - Methods

    private func configureViews() {
        selectionStyle = .none
        [iconImageView, titleLabel].forEach {
            contentView.addSubview($0)
        }

        configureColors()
        makeConstraints()
    }

    private func makeConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
        }
    }

    private func configureColors() {
        backgroundColor = .clear
        iconImageView.tintColor = APRAssets.gray.color
        titleLabel.textColor = APRAssets.gray.color
    }

}
