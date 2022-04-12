//
//  RecipeCreationIngredientCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 08.04.2022.
//


import UIKit
import DesignSystem

final class RecipeCreationIngredientCell: UITableViewCell {
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var ingredientView = IngredientView()

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubview(ingredientView)
        setupConstraints()
    }

    private func setupConstraints() {
        ingredientView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    // MARK: - Public methods

    func configure(with viewModel: RecipeCreationIngredientViewModelProtocol) {
        ingredientView.configure(
            name: viewModel.name,
            measurement: "\(viewModel.amount) \(viewModel.measurment)"
        )
    }
}
