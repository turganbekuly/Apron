//
//  RecipeCreationDescriptionCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 08.04.2022.
//

import UIKit
import DesignSystem

final class RecipeCreationDescriptionCell: UITableViewCell {
    // MARK: - Private properties

    var placeholder = "Напишете описание вашего блюда"

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
        label.font = TypographyFonts.semibold17
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private lazy var roudedTextView: RoundedTextView = {
        let textField = RoundedTextView(
            placeholder: "Напишете описание вашего блюда"
        )
        return textField
    }()

    // MARK: - Setup Views

    private func setupViews() {
        [titleLabel, roudedTextView].forEach { contentView.addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        roudedTextView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }

    // MARK: - Public methods

    func configure() {
        titleLabel.text = "Описание"
    }
}
