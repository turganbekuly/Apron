//
//  IngredientsListCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 08.02.2022.
//

import UIKit
import DesignSystem

final class IngredientsListCell: UITableViewCell {
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

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
        return stackView
    }()

    private lazy var ingredientName: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular16
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private lazy var ingredientMeasurement: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.bold16
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private lazy var ingredientStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()

    private lazy var ingredientsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Assets.lightGray.color
        return view
    }()

    // MARK: - Setup Views

    private func setupViews() {
        [
            serveStackView,
            ingredientsStackView,
            separatorView
        ].forEach { contentView.addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        serveStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(150)
        }

        ingredientsStackView.snp.makeConstraints {
            $0.top.equalTo(serveStackView.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview().offset(16)
            $0.bottom.equalTo(separatorView.snp.top).offset(-16)
        }

        separatorView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }

    // MARK: - Public methods

    func configure(with viewModel: IIngredientsListCellViewModel) {
        serveLabel.text = "\(viewModel.serveCount) порции"
        viewModel.ingredients.forEach {
            let amount = $0.ingredientAmount != nil ? "" : "\($0.ingredientAmount ?? 0)"
            ingredientName.text = $0.ingredientName
            ingredientMeasurement.text = "\(amount) \($0.ingredientMeasurement ?? "")"
            ingredientStackView.addArrangedSubview(ingredientName)
            ingredientStackView.addArrangedSubview(ingredientMeasurement)
            ingredientsStackView.addArrangedSubview(ingredientStackView)
        }
    }
}
