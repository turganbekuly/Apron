//
//  RecipeCreationAddIngredientCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 08.04.2022.
//

import UIKit
import DesignSystem
import Models

protocol AddIngredientCellTappedDelegate: AnyObject {
    func onAddIngredientTapped()
    func onRemoveIngredientTapped(index: Int)
}

final class RecipeCreationAddIngredientCell: UITableViewCell {
    // MARK: - Private properties
    
    private weak var newIngredientDelegate: AddIngredientCellTappedDelegate?

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

    private lazy var roudedTextField: RoundedTextField = {
        let textField = RoundedTextField(
            placeholder: "+  Добавьте ингредиенты"
        )
        textField.textField.isUserInteractionEnabled = false
        return textField
    }()

    private lazy var ingredientsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        return stackView
    }()

    // MARK: - Setup Views

    private func setupViews() {
        selectionStyle = .none
        [titleLabel, roudedTextField, ingredientsStackView].forEach { contentView.addSubview($0) }
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(onAddIngredientTapped))
        roudedTextField.addGestureRecognizer(tapGR)
        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        roudedTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(38)
        }

        ingredientsStackView.snp.makeConstraints {
            $0.top.equalTo(roudedTextField.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(8)
        }
    }

    // MARK: - User actions

    @objc
    private func onAddIngredientTapped() {
        newIngredientDelegate?.onAddIngredientTapped()
    }

    // MARK: - Public methods

    func configure(
        ingredients: [RecipeIngredient]?,
        newIngredientDelegate: AddIngredientCellTappedDelegate?
    ) {
        self.newIngredientDelegate = newIngredientDelegate
        titleLabel.text = "Ингредиенты"
        ingredientsStackView.removeAllArrangedSubviews()
        guard let ingredients = ingredients else { return }

        for ingredient in ingredients {
            let view = RecipeCreationIngredientView()
            view.configure(with: ingredient)
            view.onItemDelete = { [weak self] in
                guard let self = self,
                      let index = self.ingredientsStackView.arrangedSubviews.firstIndex(of: view) else { return }
                self.newIngredientDelegate?.onRemoveIngredientTapped(index: index)
            }
            ingredientsStackView.addArrangedSubview(view)
        }
        ingredientsStackView.layoutIfNeeded()
    }
}
