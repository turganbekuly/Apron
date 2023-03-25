//
//  AdBannerCollectionCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07.03.2023.
//

import UIKit
import APRUIKit
import RemoteConfig

final class AdBannerCollectionCell: UICollectionViewCell {
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
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 24
        return imageView
    }()

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubview(imageView)
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    private func configureCell() {
        backgroundColor = .clear
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)

        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            options: [.beginFromCurrentState],
            animations: {
                self.imageView.transform = self.imageView.transform.scaledBy(
                    x: 0.9,
                    y: 0.9
                )
            }
        )
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        touchesEnded(touches, with: event)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        UIView.animate(
            withDuration: 0.1,
            delay: 0.07,
            options: [.beginFromCurrentState],
            animations: {
                self.imageView.transform = .identity
            }
        )
    }

    // MARK: - Methods

    func configure(with model: AdBannerObject) {
        if let url = URL(string: model.bannerLink) {
            imageView.kf.setImage(
                with: url,
                placeholder: APRAssets.iconPlaceholderItem.image
            )
        }
    }
}

