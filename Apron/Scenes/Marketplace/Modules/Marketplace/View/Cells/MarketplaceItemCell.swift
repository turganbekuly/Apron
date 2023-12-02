//
//  MarketplaceItemCell.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 28.10.2023.
//

import UIKit
import APRUIKit
import Models

final class MarketplaceItemCell: UICollectionViewCell {
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views factory
    
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
        view.layer.shadowColor = APRAssets.primaryTextMain.color.cgColor
        return view
    }()
    
    private lazy var vStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .leading
        return view
    }()
    
    private lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.bold14
        label.textColor = APRAssets.primaryTextMain.color
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var itemPriceLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.bold14
        label.textColor = APRAssets.mainAppColor.color
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var stockCountLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular12
        label.textColor = APRAssets.gray.color
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    // MARK: - Setup Views
    
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubviews(itemImageView, vStackView)
        vStackView.addArrangedSubview(itemNameLabel)
        makeConstraints()
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        
        itemImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(contentView.snp.width)
        }
        
        vStackView.snp.makeConstraints {
            $0.top.equalTo(itemImageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.lessThanOrEqualToSuperview().inset(8)
        }
    }
    
    // MARK: - Methods
    
    func configure(with model: MarketplaceItemResponseBody) {
        itemImageView.kf.setImage(
            with: URL(string: model.image ?? ""),
            placeholder: APRAssets.iconPlaceholderItem.image
        )
        itemNameLabel.text = model.name
        
        if let price = model.price {
            itemPriceLabel.text = model.stockCount != 0 ? "\(price)" + " Moca Coin" : "Разобрали"
            vStackView.addArrangedSubview(itemPriceLabel)
        }
        
        
        if
            let stockCount = model.stockCount,
            let maxCount = model.maxCount
        {
            stockCountLabel.text = "Осталось \(stockCount) из \(maxCount)"
            vStackView.addArrangedSubview(stockCountLabel)
        }
        
        vStackView.layoutIfNeeded()
    }
}
