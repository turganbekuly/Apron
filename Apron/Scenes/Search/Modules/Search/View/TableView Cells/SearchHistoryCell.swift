//
//  SearchHistoryCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 18.07.2022.
//

import UIKit
import APRUIKit
import Models

final class SearchHistoryCell: UITableViewCell {
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

    lazy var historyCollectionView = SearchCollectionView()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        contentView.addSubviews(
            titleLabel,
            historyCollectionView
        )
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().offset(-8)
        }

        historyCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }

    private func configureCell() {
        backgroundColor = .clear
        selectionStyle = .none
    }

    // MARK: - Methods

    func configure(with title: String) {
        titleLabel.text = title
    }
}
