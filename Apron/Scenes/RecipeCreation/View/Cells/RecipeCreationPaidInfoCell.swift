//
//  RecipeCreationPaidInfoCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04.10.2022.
//

import UIKit
import APRUIKit

protocol RecipeCreationPaidInfoCellProtocol: AnyObject {
    func cell(didEnteredEmail email: String?)
    func cell(didEnteredPromo promo: String?)
}

final class RecipeCreationPaidInfoCell: UITableViewCell {
    // MARK: - Properties

    weak var delegate: RecipeCreationPaidInfoCellProtocol?

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var emailTitleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold16
        label.textColor = .black
        label.numberOfLines = 1
        label.text = L10n.RecipeCreation.Recipe.Paid.emailTitle
        return label
    }()

    private lazy var emailDescrLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular12
        label.textColor = .black
        label.numberOfLines = 0
        label.text = L10n.RecipeCreation.Recipe.Paid.emailDescr
        return label
    }()

    private lazy var emailTextField: RoundedTextField = {
        let textField = RoundedTextField(
            placeholder: L10n.RecipeCreation.Recipe.Paid.emailTF
        )
        textField.textField.keyboardType = .emailAddress
        textField.textField.addTarget(self, action: #selector(didEnterEmail(_:)), for: .editingChanged)
        return textField
    }()

    private lazy var promoTitleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold16
        label.textColor = .black
        label.numberOfLines = 1
        label.text = L10n.RecipeCreation.Recipe.Paid.promoTitle
        return label
    }()

    private lazy var promoDescrLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular12
        label.textColor = .black
        label.numberOfLines = 0
        label.text = L10n.RecipeCreation.Recipe.Paid.promoDescr
        return label
    }()

    private lazy var promoTextField: RoundedTextField = {
        let textField = RoundedTextField(
            placeholder: L10n.RecipeCreation.Recipe.Paid.promoTF
        )
        textField.textField.addTarget(self, action: #selector(didEnterPromo(_:)), for: .editingChanged)
        return textField
    }()

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubviews(
            emailTitleLabel,
            emailDescrLabel,
            emailTextField,
            promoTitleLabel,
            promoDescrLabel,
            promoTextField
        )
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        emailTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        emailDescrLabel.snp.makeConstraints {
            $0.top.equalTo(emailTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailDescrLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(38)
        }

        promoTitleLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        promoDescrLabel.snp.makeConstraints {
            $0.top.equalTo(promoTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        promoTextField.snp.makeConstraints {
            $0.top.equalTo(promoDescrLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    private func configureCell() {
        backgroundColor = .clear
        selectionStyle = .none
    }

    // MARK: - User actions

    @objc
    private func didEnterEmail(_ sender: UITextField) {
        delegate?.cell(didEnteredEmail: sender.text)
    }

    @objc
    private func didEnterPromo(_ sender: UITextField) {
        delegate?.cell(didEnteredPromo: sender.text)
    }

    // MARK: - Public methods

    func configure(email: String?, promo: String?) {
        if let email = email {
            emailTextField.textField.text = email
        }

        if let promo = promo {
            promoTextField.textField.text = promo
        }
    }
}
