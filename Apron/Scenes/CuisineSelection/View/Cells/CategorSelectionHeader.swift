//
//  CategorSelectionHeader.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.05.2022.
//

import APRUIKit
import UIKit

final class CategorSelectionHeader: UITableViewHeaderFooterView {
    // MARK: - Init

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = TypographyFonts.semibold20
        return label
    }()

    // MARK: - Setup Views

    private func setupViews() {
        [titleLabel].forEach { contentView.addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(8)
        }
    }

    // MARK: - Methods

    func configure(with text: String) {
        titleLabel.text = text
    }
}

