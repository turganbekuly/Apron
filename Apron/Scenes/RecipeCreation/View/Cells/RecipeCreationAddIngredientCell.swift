//
//  RecipeCreationAddIngredientCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 08.04.2022.
//

import UIKit
import DesignSystem

protocol AddIngredientCellTappedDelegate: AnyObject {
    func onAddIngredientTapped()
}

final class RecipeCreationAddIngredientCell: UICollectionViewCell {
    // MARK: - Private properties

    private weak var delegate: (UITableViewDelegate & UITableViewDataSource)? {
        didSet {
            ingredientsTableView.delegate = delegate
            ingredientsTableView.dataSource = delegate
        }
    }

    private weak var newIngredientDelegate: AddIngredientCellTappedDelegate?

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

    private lazy var ingredientsTableView: RecipeCreationIngredientsView = {
        let tableView = RecipeCreationIngredientsView()
        return tableView
    }()

    // MARK: - Setup Views

    private func setupViews() {
        [titleLabel, roudedTextField].forEach { contentView.addSubview($0) }
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
    }

    // MARK: - User actions

    @objc
    private func onAddIngredientTapped() {
        newIngredientDelegate?.onAddIngredientTapped()
    }

    // MARK: - Public methods

    func configure(
        delegate: (UITableViewDelegate & UITableViewDataSource)?,
        newIngredientDelegate: AddIngredientCellTappedDelegate?
    ) {
        self.delegate = delegate
        titleLabel.text = "Состав"
    }
}
