//
//  LoginTextField.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 23.01.2022.
//

import APRUIKit
import UIKit

final class LoginTextField: UIView {
    // MARK: - Properties

    var placeholder: String
    var title: String

    // MARK: - Init

    init(placeholder: String, title: String) {
        self.placeholder = placeholder
        self.title = title

        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold12
        label.textColor = APRAssets.primaryTextMain.color
        label.text = title
        return label
    }()

    private lazy var roundedView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 22
        view.layer.borderColor = APRAssets.primaryTextMain.color.cgColor
        view.layer.borderWidth = 1
        return view
    }()

    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.placeholder = placeholder
        textField.autocapitalizationType = .none
        return textField
    }()

    // MARK: - Setup Views

    private func setupViews() {
        isUserInteractionEnabled = true
        roundedView.isUserInteractionEnabled = true
        textField.isUserInteractionEnabled = true
        [titleLabel, roundedView].forEach { addSubview($0) }
        [textField].forEach { roundedView.addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }

        roundedView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.bottom.leading.trailing.equalToSuperview()
        }

        textField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
