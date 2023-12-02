//
//  RecipeCreationSourceURLCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.07.2022.
//

import UIKit
import APRUIKit

protocol SourceURLDelegate: AnyObject {
    func cell(_ cell: RecipeCreationSourceURLCell, didEnterSource source: String?)
}

final class RecipeCreationSourceURLCell: UITableViewCell {
    // MARK: - Public properties

    weak var delegate: SourceURLDelegate?

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
            placeholder: "Укажите ссылку на рецепт, если он не ваш"
        )
        textField.textField.addTarget(self, action: #selector(didEnterSource(_:)), for: .editingChanged)
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
    private func didEnterSource(_ sender: UITextField) {
        delegate?.cell(self, didEnterSource: sender.text)
    }

    // MARK: - Public methods

    func configure(sourceName: String?) {
        titleLabel.text = "Источник"
        roudedTextField.textField.text = sourceName ?? ""
    }
}
