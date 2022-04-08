//
//  RecipeCreationNamingCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 29.03.2022.
//

import UIKit
import DesignSystem

final class RecipeCreationNamingCell: UITableViewCell, UITextFieldDelegate {
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var roudedTextField: RoundedTextField = {
        let textField = RoundedTextField(
            delegate: self,
            placeholder: "Напишите название рецепта"
        )
        return textField
    }()

    // MARK: - Setup Views

    private func setupViews() {
        selectionStyle = .none
        [roudedTextField].forEach { contentView.addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        roudedTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }

    // MARK: - Public methods

    func configure() {
//        recipeNameLabel.text = "Recipe name"
    }
}
