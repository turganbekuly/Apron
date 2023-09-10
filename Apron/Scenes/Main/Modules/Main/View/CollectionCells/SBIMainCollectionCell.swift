//
//  SBIMainCollectionCell.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 10.09.2023.
//

import UIKit
import APRUIKit
import Models

final class SBIMainCollectionCell: UICollectionViewCell {
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    // MARK: - Views factory

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold10
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
        
        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            options: [.beginFromCurrentState],
            animations: {
                self.contentView.transform = self.contentView.transform.scaledBy(
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
                self.contentView.transform = .identity
            }
        )
    }

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubviews(imageView, nameLabel)
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }

        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(8)
            $0.centerY.equalTo(imageView.snp.centerY)
            $0.trailing.equalToSuperview().inset(8)
        }
    }

    private func configureCell() {
        backgroundColor = APRAssets.gray.color
    }

    // MARK: - Methods

    func configure(with product: Product) {
        imageView.kf.setImage(
            with: URL(string: product.image ?? ""),
            placeholder: APRAssets.iconPlaceholderItem.image,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.4)),
                .cacheOriginalImage
            ]
        )
        nameLabel.text = product.name
    }
}


