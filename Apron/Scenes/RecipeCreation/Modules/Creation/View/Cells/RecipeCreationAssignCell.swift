//
//  RecipeCreationAssignCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.04.2022.
//

import UIKit
import APRUIKit
import SnapKit

protocol RecipeCreationAssignCellDelegate: AnyObject {
    func assignButtonTapped(with type: AssignTypes?)
}

final class RecipeCreationAssignCell: UITableViewCell {
    // MARK: - Public properties

    weak var delegate: RecipeCreationAssignCellDelegate?

    // MARK: - Private properties

    let attributes: [NSAttributedString.Key: Any] = [
        .font: TypographyFonts.bold14,
        .foregroundColor: UIColor.black,
        .underlineStyle: NSUnderlineStyle.single.rawValue
    ]

    private var type: AssignTypes?

    private var buttonWidth: Constraint?

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        button.titleLabel?.font = TypographyFonts.bold14
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(assignButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var subtitlLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular12
        label.textColor = APRAssets.gray.color
        label.textAlignment = .left
        label.numberOfLines = 2
        label.sizeToFit()
        return label
    }()

    // MARK: - Setup Views

    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
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
            buttonWidth = $0.width.equalTo(55).constraint
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(assignButton.snp.leading).offset(-16)
        }

        subtitlLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(assignButton.snp.leading).offset(-16)
            $0.bottom.equalToSuperview()
        }
    }

    // MARK: - User actions

    @objc
    private func assignButtonTapped() {
        delegate?.assignButtonTapped(with: type)
    }

    // MARK: - Public properties

    func configure(type: AssignTypes) {
        self.type = type
        switch type {
        case let .servings(value):
            titleLabel.text = L10n.RecipeCreation.Recipe.ServingCount.title
            assignButton.setTitle(value == "0" ? L10n.RecipeCreation.Recipe.AssignButton.title : value, for: .normal)
            subtitlLabel.text = L10n.RecipeCreation.Recipe.ServingCount.subtitle
            if !value.isEmpty {
                buttonWidth?.update(offset: 80)
            }
        case let .cookTime(value):
            titleLabel.text = L10n.RecipeCreation.Recipe.CookTime.title
            assignButton.setTitle(value == "0" ? L10n.RecipeCreation.Recipe.AssignButton.title : "\(value) \(L10n.Common.Measure.minutes)", for: .normal)
            subtitlLabel.text = L10n.RecipeCreation.Recipe.CookTime.subtitle
            if !value.isEmpty {
                buttonWidth?.update(offset: 80)
            }
        default:
            break
        }
    }
}