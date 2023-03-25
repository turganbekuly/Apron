//
//  RecipeIngredientsViewCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25.02.2022.
//

import UIKit
import APRUIKit
import HapticTouch

final class RecipeIngredientsViewCell: UITableViewCell {
    // MARK: - Properties

    private var servingCount = 0 {
        didSet {
            serveLabel.text = "\(servingCount) порции"
            ingredientsStackView.subviews.forEach {
                if let view = $0 as? IngredientView {
                    view.changeServings(initialCount: initialServeCount, changedCount: servingCount)
                }
            }
        }
    }

    private var initialServeCount = 0 {
        didSet {
            servingCount = initialServeCount
        }
    }

    var onAddToCartTapped: (() -> Void)?

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
        label.textAlignment = .left
        return label
    }()

    private lazy var minusButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        button.setImage(APRAssets.minusButtonIcon.image, for: .normal)
        button.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var plusButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        button.setImage(APRAssets.plusButtonIcon.image, for: .normal)
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
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

    private lazy var addToCartButton: NavigationButton = {
        let button = NavigationButton()
        button.backgroundType = .blackBackground
        button.isImageVisible = false
        button.showShadow = true
        button.setTitle("Добавить в корзину".uppercased(), for: .normal)
        button.addTarget(self, action: #selector(addToCartTapped), for: .touchUpInside)
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        return button
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = APRAssets.lightGray2.color
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
            addToCartButton,
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
            $0.height.equalTo(30)
        }

        serveStackView.snp.makeConstraints {
            $0.top.equalTo(ingredientsTitleLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(150)
            $0.height.equalTo(24)
        }

        ingredientsStackView.snp.makeConstraints {
            $0.top.equalTo(serveStackView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(addToCartButton.snp.top).offset(-16)
        }

        addToCartButton.snp.makeConstraints {
            $0.top.equalTo(ingredientsStackView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
    }

    // MARK: - User actions

    @objc
    private func minusButtonTapped() {
        guard servingCount > 1 else { return }
        servingCount -= 1
        HapticTouch.generateMedium()
    }

    @objc
    private func plusButtonTapped() {
        servingCount += 1
        HapticTouch.generateMedium()
    }

    @objc
    private func addToCartTapped() {
        HapticTouch.generateSuccess()
        onAddToCartTapped?()
    }

    // MARK: - Public methods

    func configure(with viewModel: IIngredientsListCellViewModel) {
        ingredientsTitleLabel.text = "Ингредиенты"
        self.initialServeCount = viewModel.serveCount
        ingredientsStackView.removeAllArrangedSubviews()
        viewModel.ingredients.forEach {
            let view = IngredientView()
            view.configure(
                name: $0.product?.name ?? "",
                amount: $0.amount,
                unit: $0.measurement,
                image: $0.product?.image
            )
            ingredientsStackView.addArrangedSubview(view)
        }
        ingredientsStackView.layoutIfNeeded()
    }
}
