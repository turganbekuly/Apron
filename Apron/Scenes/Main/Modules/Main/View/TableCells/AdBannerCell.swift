//
//  AdBannerCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 01.03.2023.
//

import UIKit
import APRUIKit
import RemoteConfig

protocol AdBannerCellProtocol: AnyObject {
    func adBannerTapped(with model: AdBannerObject)
}

final class AdBannerCell: UITableViewCell {
    // MARK: - Properties

    weak var delegate: AdBannerCellProtocol?

    var adBannerObject: AdBannerObject?

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold18
        label.textColor = ApronAssets.primaryTextMain.color
        label.textAlignment = .left
        return label
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = false
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 20
        view.layer.backgroundColor = UIColor.white.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 3
        view.layer.shadowColor = ApronAssets.primaryTextMain.color.cgColor
        view.isUserInteractionEnabled = true
        return view
    }()

    private lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    // MARK: - Setup Views

    private func setupViews() {
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(onBannerTapped))
        containerView.addGestureRecognizer(tapGR)
        contentView.addSubviews(titleLabel, containerView)
        containerView.addSubview(bannerImageView)
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        bannerImageView.snp.matchSuperview()
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }

    private func configureCell() {
        backgroundColor = .clear
        selectionStyle = .none
    }

    // MARK: - User actions

    @objc
    private func onBannerTapped() {
        guard let object = adBannerObject else { return }
        delegate?.adBannerTapped(with: object)
    }

    // MARK: - Public methods

    func configure(viewModel: [AdBannerObject]) {
        titleLabel.text = "Для Вас"

        guard let banner = viewModel.first else { return }

        adBannerObject = banner
        if let url = URL(string: banner.bannerLink) {
            bannerImageView.kf.setImage(
                with: url,
                placeholder: ApronAssets.iconPlaceholderItem.image
            )
        }
    }
}
