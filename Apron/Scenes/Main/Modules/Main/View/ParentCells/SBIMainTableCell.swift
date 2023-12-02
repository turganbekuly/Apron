//
//  SBIMainTableCell.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 10.09.2023.
//

import UIKit
import APRUIKit
import Models

protocol SBIMainTableCellDelegate: AnyObject {
    func sbiProductSelected()
}

final class SBIMainTableCell: UICollectionViewCell {
    // MARK: - Properties

    lazy var productsSection: [SBIMainSection] = [] {
        didSet {
            productsCollectionView.reloadData()
        }
    }

    weak var delegate: SBIMainTableCellDelegate?
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold18
        label.textColor = APRAssets.primaryTextMain.color
        label.textAlignment = .left
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular14
        label.textColor = APRAssets.gray.color
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var seeAllButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = TypographyFonts.regular16
        button.setTitleColor(APRAssets.gray.color, for: .normal)
        button.setTitleColor(APRAssets.gray.color, for: .highlighted)
        button.setTitle(L10n.Common.all, for: .normal)
        button.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var productsCollectionView = SBICollectionView()

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubviews(
            titleLabel,
            descriptionLabel,
            productsCollectionView,
            seeAllButton
        )
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(seeAllButton.snp.leading).offset(-8)
        }
        
        seeAllButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        productsCollectionView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func configureCell() {
        backgroundColor = .clear
    }
    
    // MARK: - User actions
    
    @objc
    private func seeAllButtonTapped() {
        delegate?.sbiProductSelected()
    }
    
    // MARK: - Public methods

    func configure(with viewModel: SBIMainViewModel) {
        titleLabel.text = viewModel.sectionTitle
        descriptionLabel.text = viewModel.sectionDescription
        productsSection = [
            .init(section: .products, rows: viewModel.products.compactMap { .product($0) }),
//            .init(section: .products, rows: [.seeAll])
        ]
    }
}

