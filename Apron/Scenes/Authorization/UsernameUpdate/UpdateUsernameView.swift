//
//  UpdateUsernameView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25.03.2023.
//

import UIKit
import APRUIKit

final class UpdateUsernameView: UIView {
    // MARK: - Properties

    var username: String?
    var onSaveButtonTapped: ((String) -> Void)?

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    // MARK: - Views factory

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = APRAssets.primaryTextMain.color
        label.font = TypographyFonts.semibold20
        label.text = "Привет!"
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = APRAssets.primaryTextMain.color
        label.font = TypographyFonts.semibold14
        label.text = "Заполните ваше имя для продолжения"
        return label
    }()

    lazy var roundedTextField: RoundedTextField = {
        let textField = RoundedTextField(placeholder: "Имя")
        textField.textField.addTarget(self, action: #selector(roundedTextFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()

    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 22
        button.setBackgroundColor(APRAssets.primaryTextMain.color, for: .normal)
        button.titleLabel?.font = TypographyFonts.regular16
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Сохранить", for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Setup Views

    private func setupViews() {
        addSubviews(
            titleLabel,
            subtitleLabel,
            roundedTextField,
            saveButton
        )
        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
        }

        roundedTextField.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }

        saveButton.snp.makeConstraints { make in
            make.top.equalTo(roundedTextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().inset(16)
        }
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    }

    // MARK: - User actions

    @objc
    private func roundedTextFieldDidChange(_ sender: UITextField) {
        username = sender.text
        saveButton.isEnabled = sender.text?.isEmpty == false
    }

    @objc
    private func saveButtonTapped() {
        guard let name = username, !name.isEmpty else { return }
        onSaveButtonTapped?(name)
    }
}
