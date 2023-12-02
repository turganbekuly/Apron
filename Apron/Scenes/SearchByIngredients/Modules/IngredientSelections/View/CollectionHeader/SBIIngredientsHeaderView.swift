//
//  SBIIngredientsHeaderView.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 19.08.2023.
//

import UIKit
import APRUIKit

final class SBIIngredientsHeaderView: UICollectionReusableView {

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
        label.textAlignment = .left
        label.font = TypographyFonts.semibold14
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        addSubview(titleLabel)
        setupConstraints()
        configureColor()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    private func configureColor() {
        backgroundColor = APRAssets.secondary.color
    }

    // MARK: - Methods

    func configure(with text: String) {
        self.titleLabel.text = text
    }
}
