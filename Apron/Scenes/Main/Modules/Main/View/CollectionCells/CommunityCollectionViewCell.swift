//
//  CommunityCollectionViewCell.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 13.08.2023.
//

import UIKit
import APRUIKit
import Storages
import HapticTouch
import SnapKit
import Models

final class CommunityCollectionViewCell: UICollectionViewCell {
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views factory
    
    private lazy var topView: RoundedTopView = {
        let view = RoundedTopView()
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = false
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 15
        view.layer.backgroundColor = UIColor.white.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 3
        view.layer.shadowColor = APRAssets.primaryTextMain.color.cgColor
        return view
    }()
    
    private lazy var avatarOverlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 18
        view.layer.backgroundColor = UIColor.white.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 8)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 16
        view.layer.shadowColor = UIColor(red: 0.573, green: 0.573, blue: 0.573, alpha: 0.15).cgColor
        return view
    }()

    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 14
        imageView.image = APRAssets.mocaGreenLogo.image
        return imageView
    }()
    
    private lazy var communityLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold16
        label.textColor = APRAssets.primaryTextMain.color
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubviews(
            topView,
            avatarOverlayView,
            communityLabel
        )
        avatarOverlayView.addSubview(avatarImageView)
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        topView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(163)
        }

        avatarOverlayView.snp.makeConstraints {
            $0.size.equalTo(38)
            $0.centerY.equalTo(topView.snp.bottom)
            $0.trailing.equalTo(topView.snp.trailing).offset(-8)
        }

        avatarImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.size.equalTo(28)
        }

        communityLabel.snp.makeConstraints {
            $0.top.equalTo(avatarOverlayView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.trailing.equalToSuperview().inset(8)
        }
    }

    private func configureCell() {
        contentView.backgroundColor = .clear
    }
    
    // MARK: - Methods
    
    func configure(community: CommunityResponse) {
        topView.configure(with: RoundedTopViewModel(image: community.image, label: "\(community.recipesCount ?? 0) рецептов"))
        communityLabel.text = community.name
    }
}
