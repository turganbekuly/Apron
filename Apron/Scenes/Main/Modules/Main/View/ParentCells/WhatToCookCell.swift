//
//  WhatToCookCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.10.2022.
//

import UIKit
import APRUIKit
import Models

protocol WhatToCookCellDelegate: AnyObject {
    func navigateToCategoryRecipes(with type: WhatToCookCategoryTypes)
}

final class WhatToCookCell: UICollectionViewCell {
    // MARK: - Proeprties

    weak var delegate: WhatToCookCellDelegate?
    lazy var categoriesSection: [WhatToCookSection] = [] {
        didSet {
            whatToCookCollectionView.reloadData()
        }
    }

    var title = "" {
        didSet {
            titleLabel.text = title
        }
    }

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

    lazy var whatToCookCollectionView = WhatToCookCollectionView()

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubviews(titleLabel, whatToCookCollectionView)
        whatToCookCollectionView.delegate = self
        whatToCookCollectionView.dataSource = self
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        whatToCookCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func configureCell() {
        backgroundColor = .clear
    }

    // MARK: - Public methods

    func configure(with viewModel: WhatToCookCellViewModelProtocol) {
        title = viewModel.sectionHeaderTitle
        categoriesSection = [
            .init(
                section: .categories,
                rows: WhatToCookCategoryTypes.allCases.compactMap { .category($0) }
            )
        ]
    }
}
