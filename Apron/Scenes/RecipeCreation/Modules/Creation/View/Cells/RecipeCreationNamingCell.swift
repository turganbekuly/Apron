//
//  RecipeCreationNamingCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 29.03.2022.
//

import UIKit
import APRUIKit

protocol NamingCellDelegate: AnyObject {
    func cell(_ cell: RecipeCreationNamingCell, didEnteredName name: String?)
}

final class RecipeCreationNamingCell: UITableViewCell {
    // MARK: - Public properties

    weak var delegate: NamingCellDelegate?

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

    private lazy var roudedTextField: RoundedTextField = {
        let textField = RoundedTextField(
            placeholder: L10n.RecipeCreation.Recipe.Name.tfPlaceholder
        )
        textField.textField.addTarget(self, action: #selector(didEnterName(_:)), for: .editingChanged)
        return textField
    }()

    // MARK: - Setup Views

    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        [titleLabel, roudedTextField].forEach { contentView.addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        roudedTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(38)
            $0.bottom.lessThanOrEqualToSuperview()
        }
    }

    // MARK: - User actions

    @objc
    private func didEnterName(_ sender: UITextField) {
        delegate?.cell(self, didEnteredName: sender.text)
    }

    // MARK: - Public methods

    func configure(recipeName: String?) {
        titleLabel.text = "Название рецепта"
        roudedTextField.textField.text = recipeName ?? ""
    }
}
