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
        return label
    }()

    private lazy var scaleImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private lazy var calPerServingLabel: UILabel = {
        let label = UILabel()
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
        return stackView
    }()

    // MARK: - Setup Views

    private func setupViews() {
        [stackView].forEach {
            addSubview($0)
        }

        setupConstraints()
    }

    private func setupConstraints() {
        firstDivider.snp.makeConstraints {
            $0.width.equalTo(1)
        }

        secondDivider.snp.makeConstraints {
            $0.width.equalTo(1)
        }

        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Public methods

    func configure() {
        fatView.configure(type: "Fat", measure: "25 g")
        proteinView.configure(type: "Protein", measure: "44 g")
        carbsView.configure(type: "Carbs", measure: "12 g")
    }
}
