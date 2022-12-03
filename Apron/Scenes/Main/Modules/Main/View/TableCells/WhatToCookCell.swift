//
//  WhatToCookCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.10.2022.
//

import UIKit
import APRUIKit
import Models

protocol WhatToCookCellProtocol: AnyObject {
    func navigateToCategory(with id: Int)
}

final class WhatToCookCell: UITableViewCell {
    // MARK: - Proeprties

    weak var delegate: WhatToCookCellProtocol?
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold18
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    lazy var whatToCookCollectionView = WhatToCookView()

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
            $0.top.leading.trailing.equalToSuperview().inset(16)
        }

        whatToCookCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func configureCell() {
        backgroundColor = .clear
        selectionStyle = .none
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
