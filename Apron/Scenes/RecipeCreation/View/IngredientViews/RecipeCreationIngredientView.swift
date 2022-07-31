//
//  RecipeCreationIngredientView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 08.04.2022.
//


import UIKit
import APRUIKit
import Models

final class RecipeCreationIngredientView: UIView {
    // MARK: - Properties

    var onItemDelete: (() -> Void)?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
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
        label.numberOfLines = 2
        label.sizeToFit()
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
        button.setImage(ApronAssets.trashIcon.image, for: .normal)
        button.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Setup Views

    private func setupViews() {
        addSubview(containerView)
        containerView.addSubviews(ingredientLabel, measurementLabel, removeButton)
        setupConstraints()
    }

    private func setupConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(38)
        }
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        removeButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(24)
        }

        measurementLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(80)
        }

        ingredientLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(measurementLabel.snp.trailing).offset(8)
            $0.trailing.equalTo(removeButton.snp.leading).offset(-8)
        }

    }

    // MARK: - User actions

    @objc
    private func removeButtonTapped() {
        onItemDelete?()
    }

    // MARK: - Public methods

    func configure(with viewModel: RecipeIngredient) {
        var measurementText = ""
        ingredientLabel.text = viewModel.product?.name
        if let amount = viewModel.amount {
            measurementText = "\(amount.clean)"
        }
        if let measure = viewModel.measurement {
            measurementText += measure
        }
        measurementLabel.text = measurementText
    }
}
