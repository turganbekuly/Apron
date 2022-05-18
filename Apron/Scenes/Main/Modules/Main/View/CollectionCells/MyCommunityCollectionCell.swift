//
//  MyCommunityCollectionCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17.05.2022.
//

import DesignSystem
import UIKit
import Kingfisher
import HapticTouch

final class MyCommunityCollectionCell: UICollectionViewCell {
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleToFill
        imageView.image = Assets.cmntImageview.image
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var communityNameLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular12
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        [imageView, communityNameLabel].forEach { contentView.addSubview($0) }
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }

        communityNameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }
    }

    private func configureCell() {
        backgroundColor = .clear
    }

    // MARK: - Methods

    func configure(with viewModel: MyCommunityCollectionViewModelProtocol) {
        guard let community = viewModel.community else { return }
        imageView.kf.setImage(
            with: URL(string: community.image ?? ""),
            placeholder: Assets.iconPlaceholderCard.image
        )
        communityNameLabel.text = community.name ?? ""
    }
}

