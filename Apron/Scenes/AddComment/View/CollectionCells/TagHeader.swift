//
//  TagHeader.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.08.2022.
//

import UIKit
import APRUIKit

final class TagHeader: UICollectionReusableView {
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
            $0.leading.trailing.equalToSuperview()
        }
    }

    private func configureColor() {
        backgroundColor = ApronAssets.secondary.color
    }

    // MARK: - Methods

    func configure(title: String) {
        sectionHeaderLabel.text = title
    }
}

