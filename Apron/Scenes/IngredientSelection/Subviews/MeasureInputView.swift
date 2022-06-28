//
//  MeasureInputView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21.04.2022.
//

import UIKit
import APRUIKit

protocol MeasureInputViewProtocol: AnyObject {
    func measurementTextFieldDidChange(text: String?)
}

final class MeasureInputView: UIView {
    // MARK: - Private properties

    private var amountPlaceholder: String?
    private var measurePlaceholder: String?

    // MARK: - Public properties

    weak var delegate: MeasureInputViewProtocol?

    // MARK: - Init

    init(amountPlaceholder: String?, measurePlaceholder: String?) {
        self.amountPlaceholder = amountPlaceholder
        self.measurePlaceholder = measurePlaceholder

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

    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = ApronAssets.gray.color
        return view
    }()

    public lazy var amountTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = amountPlaceholder
        textfield.backgroundColor = .clear
        textfield.font = TypographyFonts.regular12
        textfield.keyboardType = .decimalPad
        return textfield
    }()

    public lazy var measurementTyptextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = measurePlaceholder
        textfield.backgroundColor = .clear
        textfield.font = TypographyFonts.regular12
        textfield.addTarget(self, action: #selector(measureTextFieldChanged(_:)), for: .editingChanged)
        return textfield
    }()

    // MARK: - Setup Views

    private func setupViews() {
        addSubview(containerView)
        [amountTextField, dividerView, measurementTyptextField].forEach {
            containerView.addSubview($0)
        }
        setupConstraints()
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        dividerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(4)
            $0.width.equalTo(1)
        }

        amountTextField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(dividerView.snp.leading).offset(-8)
        }

        measurementTyptextField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.equalTo(dividerView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(16)
        }
    }

    // MARK: - User actions

    @objc
    private func measureTextFieldChanged(_ sender: UITextField) {
        delegate?.measurementTextFieldDidChange(text: sender.text)
    }
}
