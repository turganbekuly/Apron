//
//  RecipeIngredientsViewCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25.02.2022.
//

import UIKit
import DesignSystem

final class RecipeIngredientsViewCell: UITableViewCell {
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var ingredientsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold20
        label.textColor = .black
        label.text = "Ингредиенты"
        label.textAlignment = .left
        return label
    }()

    private lazy var minusButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        button.setImage(Assets.minusButtonIcon.image, for: .normal)
        return button
    }()

    private lazy var plusButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        button.setImage(Assets.plusButtonIcon.image, for: .normal)
        return button
    }()

    private lazy var serveLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular14
        label.textColor = .black
        return label
    }()

    private lazy var serveStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            minusButton,
            serveLabel,
            plusButton
        ])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        return stackView
    }()

    private lazy var ingredientImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private lazy var ingredientsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Assets.lightGray2.color
        return view
    }()
    // MARK: - Setup Views

    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear

        [
            ingredientsTitleLabel,
            serveStackView,
            ingredientsStackView,
            separatorView
        ].forEach { contentView.addSubviews($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        separatorView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        ingredientsTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        serveStackView.snp.makeConstraints {
            $0.top.equalTo(ingredientsTitleLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(150)
        }

        ingredientsStackView.snp.makeConstraints {
            $0.top.equalTo(serveStackView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(separatorView.snp.top).offset(-16)
        }
    }

    // MARK: - Public methods

    func configure(with viewModel: IIngredientsListCellViewModel) {
        serveLabel.text = "\(viewModel.serveCount) порции"
        ingredientsStackView.removeAllArrangedSubviews()
        viewModel.ingredients.forEach {
            let view = IngredientView()
            view.configure(
                name: $0.ingredientName,
                measurement: "\($0.ingredientAmount ?? "0")  \($0.ingredientMeasurement ?? "")"
            )
            
            ingredientsStackView.addArrangedSubview(view)
        }
        ingredientsStackView.layoutIfNeeded()
    }
}
