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
        stackView.distribution = .equalCentering
        return stackView
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
        [
            serveStackView,
            ingredientsStackView,
            separatorView
        ].forEach { contentView.addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        separatorView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        serveStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(150)
        }

        ingredientsStackView.snp.makeConstraints {
            $0.top.equalTo(serveStackView.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(82)
            $0.bottom.equalTo(separatorView.snp.top).offset(-16)
        }
    }

    // MARK: - Reusable cell

    override func prepareForReuse() {
        super.prepareForReuse()
        ingredientsStackView.subviews.forEach {
            $0.removeFromSuperview()
        }
    }

    // MARK: - Public methods

    func configure(with viewModel: IIngredientsListCellViewModel) {
        serveLabel.text = "\(viewModel.serveCount) порции"
        viewModel.ingredients.forEach {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .equalCentering

            let ingredientName = UILabel()
            ingredientName.font = TypographyFonts.regular16
            ingredientName.textColor = .black
            ingredientName.textAlignment = .left

            let ingredientMeasurement = UILabel()
            ingredientMeasurement.font = TypographyFonts.bold16
            ingredientMeasurement.textColor = .black
            ingredientMeasurement.textAlignment = .left

            stackView.addArrangedSubview(ingredientName)
            stackView.addArrangedSubview(ingredientMeasurement)
            let amount = $0.ingredientAmount == nil || $0.ingredientAmount == "0" ? "" : "\($0.ingredientAmount ?? "0")"
            ingredientName.text = $0.ingredientName
            ingredientMeasurement.text = "\(amount) \($0.ingredientMeasurement ?? "")"
            ingredientsStackView.addArrangedSubview(stackView)
        }
        ingredientsStackView.setNeedsUpdateConstraints()
    }
}
