//
//  SearchByIngredientsResultHeaderView.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 01.12.2023.
//

import UIKit
import APRUIKit

final class SearchByIngredientsResultHeaderView: UICollectionReusableView {
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var sectionHeaderLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold17
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        addSubview(sectionHeaderLabel)
        setupConstraints()
        configureColor()
    }

    private func setupConstraints() {
        sectionHeaderLabel.snp.makeConstraints {
            $0.bottom.top.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    private func configureColor() {
        backgroundColor = APRAssets.secondary.color
    }

    // MARK: - Methods

    func configure(title: String) {
        sectionHeaderLabel.text = title
    }
}
