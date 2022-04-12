//
//  RecipeCreationAssignCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.04.2022.
//

import UIKit
import DesignSystem

final class RecipeCreationAssignCell: UICollectionViewCell {
    // MARK: - Private properties

    let attributes: [NSAttributedString.Key: Any] = [
        .font: TypographyFonts.bold14,
        .foregroundColor: UIColor.black,
        .underlineStyle: NSUnderlineStyle.single.rawValue
    ]

    private var type: AssignTypes?

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

    private lazy var assignButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(assignButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var subtitlLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular12
        label.textColor = Assets.gray.color
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubviews(
            titleLabel,
            subtitlLabel,
            assignButton
        )
        setupConstraints()
    }

    private func setupConstraints() {
        assignButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(52)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(assignButton.snp.leading).offset(-16)
        }

        subtitlLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(assignButton.snp.leading).offset(-16)
        }
    }

    // MARK: - User actions

    @objc
    private func assignButtonTapped() {
        //
    }

    // MARK: - Public properties

    func configure(type: AssignTypes) {
        self.type = type
        switch type {
        case .servings:
            titleLabel.text = "Количество"
            let attributeString = NSMutableAttributedString(
                string: "Задать",
                attributes: attributes
            )
            assignButton.setAttributedTitle(attributeString, for: .normal)
            subtitlLabel.text = "Используется для изменения рецепта и подсчитывания каллорийности блюда"
        case .prepTime:
            titleLabel.text = "Время приготовления"
            let attributeString = NSMutableAttributedString(
                string: "Задать",
                attributes: attributes
            )
            assignButton.setAttributedTitle(attributeString, for: .normal)
            subtitlLabel.text = "Сколько времени нужно, что бы подготовить это блюдо?"
        case .cookTime:
            titleLabel.text = "Время готовки"
            let attributeString = NSMutableAttributedString(
                string: "Задать",
                attributes: attributes
            )
            assignButton.setAttributedTitle(attributeString, for: .normal)
            subtitlLabel.text = "Сколько времени нужно, что бы приготовить это блюдо?"
        }
    }
}
