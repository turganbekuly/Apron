//
//  APSearchBar.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.05.2022.
//

import UIKit
import DesignSystem
import SnapKit

public protocol SearchBarDelegate: AnyObject {
    func searchBar(_ searchBar: APSearchBar, textDidChange text: String)
}

public final class APSearchBar: UIView {
    public struct Item {
        let icon: String
        var badge: Int?
        let action: (() -> Void)?
    }

    public enum CancelButtonMode {
        case always
        case whiteEditing
        case never
    }

    // MARK: - Public properties

    public var placeholder: String? {
        didSet {
            setPlaceholder(placeholder)
        }
    }

    public var text: String? {
        get { textField.text }
        set { textField.text = newValue }
    }

    public var isEnabledEditing = true
    public var onTouchedTextField: (() -> Void)?
    public var onTouchedCancelButton: (() -> Void)?
    public var shouldReturn: ((UITextField) -> Bool)?

    public var canceButtonMode: CancelButtonMode = .whiteEditing {
        didSet {
            if canceButtonMode == .always {
                showCancelButton(animated: false)
            }
        }
    }

    public var clearButtonMode: UITextField.ViewMode = .never {
        didSet {
            textField.clearButtonMode = clearButtonMode
        }
    }

    public var returnKeyType: UIReturnKeyType = .default {
        didSet {
            textField.returnKeyType = returnKeyType
        }
    }

    public weak var delegate: SearchBarDelegate?

    // MARK: - UI Elements

    private lazy var contentView: UIImageView = {
        let view = UIImageView()
        view.image = ApronAssets.searchRoundedView.image.withRenderingMode(.alwaysOriginal)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var hContentStackView = UIStackView()
    private lazy var textField: CustomClearTextField = {
        let textField = CustomClearTextField()
        textField.tintColor = ApronAssets.gray.color
//        textField.textColor = .colorFromKit(.textColorText)
        textField.backgroundColor = .clear
        textField.font = TypographyFonts.regular12
        textField.defaultTextAttributes.updateValue(0.15, forKey: NSAttributedString.Key.kern)
        return textField
    }()
    private lazy var iconImageView = UIImageView()
    private lazy var leftView = UIView()
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(
            ApronAssets.colorsYello.color,
            for: .normal
        )

        button.titleLabel?.font = TypographyFonts.semibold14
        return button
    }()
    private lazy var rightItemsStackView = UIStackView()

    // MARK: - Private properties

    private var contentViewToCancelTrailingConstraint: Constraint?
    private var contentViewToItemsTrailingConstraint: Constraint?
    private var contentViewTrailingConstraint: Constraint?
    private var rightItemsWidthConstraint: Constraint?

    private var icon = ApronAssets.navSearchIcon.image {
        didSet {
            iconImageView.image = icon
        }
    }

    private var iconInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 8)

    // MARK: - Lifecycle

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
    }

    // MARK: - Configuration

    public func setupViews() {
        backgroundColor = .clear
        addSubviews(contentView, cancelButton, rightItemsStackView)
        contentView.addSubview(hContentStackView)
        hContentStackView.addArrangedSubview(leftView, insets: iconInsets)
        leftView.addSubview(iconImageView)
        hContentStackView.addArrangedSubview(
            textField,
            insets: .init(top: 0, left: 0, bottom: 0, right: 8)
        )

        iconImageView.image = icon
        leftView.addSubview(iconImageView)
        textField.autocorrectionType = .no
        textField.leftViewMode = .always
        iconImageView.contentMode = .scaleAspectFit

        textField.addTarget(
            self,
            action: #selector(textFieldDidChange(_:)),
            for: .editingChanged
        )

        textField.clearButtonMode = clearButtonMode
        textField.delegate = self

        cancelButton.setTitle(
            "Cancel",
            for: .normal
        )
        cancelButton.addTarget(
            self,
            action: #selector(cancelTouched),
            for: .touchUpInside
        )

        cancelButton.alpha = 0.0
        cancelButton.isHidden = true
        rightItemsStackView.isHidden = true
        rightItemsStackView.alpha = 0.0

        setPlaceholder("Localizable.SearchBar.placeholder.localized()")

        cancelButton.setContentHuggingPriority(.required, for: .horizontal)
        cancelButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        setupConstraints()
    }

    public func setupConstraints() {
        contentView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(16)

            contentViewToCancelTrailingConstraint = make.trailing
                .equalTo(cancelButton.snp.leading)
                .offset(-26)
                .constraint

            contentViewToItemsTrailingConstraint = make.trailing
                .equalTo(rightItemsStackView.snp.leading)
                .offset(-15)
                .constraint

            contentViewTrailingConstraint = make.trailing
                .equalToSuperview()
                .offset(-16)
                .constraint

            make.bottom.equalToSuperview()
            make.height.equalTo(40)
        }

        contentViewToCancelTrailingConstraint?.deactivate()
        contentViewToItemsTrailingConstraint?.deactivate()

        hContentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        iconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.size.equalTo(16)
        }

        cancelButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalToSuperview().offset(-14)
        }

        rightItemsStackView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalToSuperview().offset(-29)
            rightItemsWidthConstraint = make.width.equalTo(0).constraint
        }

        if canceButtonMode == .always {
            self.showCancelButton(animated: false)
        }
    }

    // MARK: - Public methods

    @discardableResult
    public override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }

    @discardableResult
    public override func resignFirstResponder() -> Bool {
        return textField.resignFirstResponder()
    }
}

private extension APSearchBar {
    func showCancelButton(animated: Bool = true) {
        contentViewToItemsTrailingConstraint?.deactivate()
        contentViewTrailingConstraint?.deactivate()
        contentViewToCancelTrailingConstraint?.activate()

        UIView.animate(
            withDuration: animated ? 0.25 : 0,
            animations: {
                self.layoutIfNeeded()
                self.rightItemsStackView.alpha = 0.0
            }, completion: { _ in
                self.rightItemsStackView.isHidden = true
            }
        )

        self.cancelButton.isHidden = false

        UIView.animate(
            withDuration: animated ? 0.25 : 0,
            delay: 0.1,
            animations: {
                self.cancelButton.alpha = 1.0
            }
        )
    }

    func hideCancelButton() {
        contentViewToItemsTrailingConstraint?.deactivate()
        contentViewTrailingConstraint?.activate()
        contentViewToCancelTrailingConstraint?.deactivate()

        UIView.animate(
            withDuration: 0.25,
            animations: {
                self.layoutIfNeeded()
                self.cancelButton.alpha = 0.0
            }, completion: { _ in
                self.cancelButton.isHidden = true
            }
        )
    }
}

// MARK: - UITextFieldDelegate

extension APSearchBar: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return shouldReturn?(textField) ?? true
    }

    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        onTouchedTextField?()
        return isEnabledEditing
    }

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        guard canceButtonMode == .whiteEditing else { return }
        showCancelButton()
    }

    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard canceButtonMode == .whiteEditing else { return true }
        return true
    }
}

// MARK: - Private methods

private extension APSearchBar {
    func setPlaceholder(_ placeholder: String?) {
        guard let placeholder = placeholder else {
            textField.attributedPlaceholder = nil
            return
        }

        let attributes: [NSAttributedString.Key: Any] = [
            .font: TypographyFonts.regular12,
            .kern: 0.15,
            .foregroundColor: UIColor.gray
        ]

        let attrString = NSAttributedString(
            string: placeholder,
            attributes: attributes
        )

        textField.attributedPlaceholder = attrString
    }

    @objc
    func textFieldDidChange(_ textField: UITextField) {
        delegate?.searchBar(self, textDidChange: textField.text ?? "")
    }

    @objc
    func cancelTouched() {
        textField.resignFirstResponder()
        onTouchedCancelButton?()
    }
}

