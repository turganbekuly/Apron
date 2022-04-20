//
//  RecipeCreationIngredientCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 08.04.2022.
//


import UIKit
import DesignSystem
import Models

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

    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 19
        view.clipsToBounds = true
        return view
    }()

    private lazy var measurementLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold12
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private lazy var ingredientLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold12
        label.textColor = .black
        label.numberOfLines = 2
        label.sizeToFit()
        label.textAlignment = .left
        return label
    }()

    private lazy var removeButton: UIButton = {
        let button = UIButton()
        button.setImage(Assets.trashIcon.image, for: .normal)
        return button
    }()

    // MARK: - Setup Views

    private func setupViews() {
        selectionStyle = .none
        contentView.addSubview(containerView)
        containerView.addSubviews(ingredientLabel, measurementLabel, removeButton)
        setupConstraints()
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        removeButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(24)
        }

        measurementLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(80)
        }

        ingredientLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.leading.equalTo(measurementLabel.snp.trailing).offset(8)
            $0.trailing.equalTo(removeButton.snp.leading).offset(-8)
            $0.bottom.equalToSuperview().inset(4)
        }

    }

    // MARK: - Public methods

    func configure(with viewModel: IngredientInfo) {
        ingredientLabel.text = viewModel.ingredientName
        if let amount = viewModel.ingredientAmount,
           let measure = viewModel.ingredientMeasurement {
            measurementLabel.text = "\(amount) \(measure)"
        }
    }
}
