//
//  RoundedTextField.swift
//  DesignSystem
//
//  Created by Akarys Turganbekuly on 27.03.2022.
//

import UIKit

public class RoundedTextField: UIView {
    // MARK: - Private properties

    private var placeholder: String?

    // MARK: - Init

    public init(
        placeholder: String?
    ) {
        self.placeholder = placeholder

        super.init(frame: .zero)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 19
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()

    public lazy var textField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = placeholder
        textfield.backgroundColor = .clear
        textfield.font = TypographyFonts.regular12
        return textfield
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        addSubview(containerView)
        containerView.addSubview(textField)
        setupConstraints()
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        textField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
