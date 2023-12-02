//
//  OrderOnlineOnboardingCell.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 23.08.2023.
//

import UIKit
import APRUIKit

final class OrderOnlineOnboardingCell: UICollectionViewCell {
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
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Setup Views
    
    private func setupViews() {
        contentView.addSubview(imageView)
        makeConstraints()
    }
    
    private func makeConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Method
    
    func configure(with imageURL: UIImage) {
//        imageView.kf.setImage(
//            with: URL(string: imageURL),
//            placeholder: APRAssets.iconPlaceholderCard.image
//        )
        imageView.image = imageURL
    }
}
