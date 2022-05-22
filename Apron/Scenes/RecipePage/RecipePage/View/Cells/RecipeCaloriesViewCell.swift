//
//  RecipeCaloriesViewCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25.02.2022.
//


import UIKit
import DesignSystem

final class RecipeCaloriesViewCell: UITableViewCell {
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var caloriesTitleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold20
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Калорийность"
        return label
    }()

    private lazy var scaleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = Assets.calQuaterIcon.image
        return imageView
    }()

    private lazy var calPerServingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()

    private lazy var fatView = NutritionView()
    private lazy var proteinView = NutritionView()
    private lazy var carbsView = NutritionView()
    private lazy var firstDivider = SeparatorView()
    private lazy var secondDivider = SeparatorView()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            fatView,
            firstDivider,
            proteinView,
            secondDivider,
            carbsView
        ])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        return stackView
    }()
    private lazy var sectionDivider = SeparatorView()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        [caloriesTitleLabel, scaleImageView, calPerServingLabel, stackView, sectionDivider].forEach {
            addSubview($0)
        }

        setupConstraints()
    }

    private func setupConstraints() {
        sectionDivider.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        caloriesTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        scaleImageView.snp.makeConstraints {
            $0.top.equalTo(caloriesTitleLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(53)
        }

        calPerServingLabel.snp.makeConstraints {
            $0.centerY.equalTo(scaleImageView.snp.centerY)
            $0.leading.equalTo(scaleImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(16)
        }

        firstDivider.snp.makeConstraints {
            $0.width.equalTo(1)
        }

        secondDivider.snp.makeConstraints {
            $0.width.equalTo(1)
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(scaleImageView.snp.bottom).offset(16)
            $0.bottom.equalTo(sectionDivider.snp.top).offset(-12)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    private func attributedLabelSetup(firstString: String, secondString: String) {
        let firstAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black, .font: TypographyFonts.semibold18]
        let secondAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black, .font: TypographyFonts.regular16]
        let firstString = NSMutableAttributedString(string: firstString, attributes: firstAttributes)
        let secondString = NSAttributedString(string: secondString, attributes: secondAttributes)
        firstString.append(secondString)
        calPerServingLabel.attributedText = firstString
    }

    // MARK: - Public methods

    func configure(with viewModel: CaloriesCellViewModelProtocol) {
        fatView.configure(type: "ЖИРЫ", measure: "\(viewModel.fatCount ?? 0) g")
        proteinView.configure(type: "БЕЛКИ", measure: "\(viewModel.proteinCount ?? 0) g")
        carbsView.configure(type: "УГЛЕВОДЫ", measure: "\(viewModel.carbsCount ?? 0) g")
        attributedLabelSetup(firstString: "\(viewModel.ccalCount ?? 0) ", secondString: "Ккал на 1 порцию")
    }
}
