//
//  SBIMainSeeAllCollectionCell.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 11.09.2023.
//

import UIKit
import APRUIKit
import Models

final class SBIMainSeeAllCollectionCell: UICollectionViewCell {
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

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold11
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
        contentView.addSubview(nameLabel)
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.leading.equalToSuperview().inset(8)
        }
    }

    private func configureCell() {
        contentView.backgroundColor = APRAssets.lightGray2.color
    }

    // MARK: - Methods

    func configure() {
        nameLabel.text = L10n.SearchByIngredients.Product.seeMore
    }
}



