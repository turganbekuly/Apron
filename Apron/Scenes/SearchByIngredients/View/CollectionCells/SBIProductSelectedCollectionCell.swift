//
//  SBIProductSelectedCollectionCell.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 19.08.2023.
//

import UIKit
import APRUIKit
import Models

protocol SBIProductSelectedCollectionCellProtocol: AnyObject {
    func removeSelected(product: Product)
}

final class SBIProductSelectedCollectionCell: UICollectionViewCell {
    // MARK: - Properties
    
    weak var delegate: SBIProductSelectedCollectionCellProtocol?
    private var product = Product()
    
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
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = bounds.width / 2
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold10
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var removeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = APRAssets.searchClearButton.image
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    // MARK: - Setup Views

    private func setupViews() {
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(removeSelectedProduct))
        removeImage.addGestureRecognizer(tapGR)
        contentView.addSubviews(imageView, nameLabel, removeImage)
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(bounds.width)
        }
        
        removeImage.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.top)
            $0.trailing.equalTo(imageView.snp.leading).offset(20)
            $0.size.equalTo(32)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(8)
        }
    }

    private func configureCell() {
        backgroundColor = .clear
    }
    
    // MARK: - User actions
    
    @objc
    private func removeSelectedProduct() {
        delegate?.removeSelected(product: product)
    }

    // MARK: - Methods

    func configure(with product: Product) {
        self.product = product
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
