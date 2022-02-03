//
//  CommunityCellHeaderView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.01.2022.
//

import DesignSystem
import UIKit

final class CommunityCellHeaderView: UITableViewHeaderFooterView {
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
        label.font = TypographyFonts.bold16
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubview(titleLabel)
        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    // MARK: - Methods

    func configure(with title: String) {
        self.titleLabel.text = title
    }
}
