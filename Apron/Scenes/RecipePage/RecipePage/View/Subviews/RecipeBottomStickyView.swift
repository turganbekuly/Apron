//
//  RecipeBottomStickyView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 24.05.2022.
//

import UIKit
import APRUIKit
import HapticTouch
import Storages

protocol BottomStickyViewDelegate: AnyObject {
    func addButtonTapped()
    func textFieldTapped()
    func navigateToStepByStepMode()
}

final class RecipeBottomStickyView: View {
    // MARK: - Properties

    weak var delegate: BottomStickyViewDelegate?

    // MARK: - Views factory

    private lazy var textField: RoundedTextField = {
        let textField = RoundedTextField(placeholder: L10n.Recipe.Reviews.tfPlaceholder)
        textField.textField.isUserInteractionEnabled = false
        return textField
    }()

    private lazy var addButton: NavigationButton = {
        let button = NavigationButton()
        button.backgroundType = .whiteBackground
        button.setTitle(L10n.Recipe.Ingredients.addToCart, for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 19
        button.clipsToBounds = true
        return button
    }()

    private lazy var cookModeButton: NavigationButton = {
        let button = NavigationButton()
        button.backgroundType = .greenBackground
        button.addTarget(self, action: #selector(cookModeButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 19
        button.clipsToBounds = true
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        button.setTitle(L10n.Recipe.Cook.StepByStep.title, for: .normal)
        button.setImage(APRAssets.recipePlayIcon.image.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        return button
    }()

    // MARK: - Setup views

    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
        textField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(commentTFTapped)))
        addSubviews(
            textField,
            addButton,
            cookModeButton
        )
    }

    override func setupConstraints() {
        super.setupConstraints()

        textField.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(38)
        }

        addButton.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(38)
            $0.trailing.equalTo(snp.centerX).offset(-5)
        }

        cookModeButton.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(38)
            $0.leading.equalTo(snp.centerX).offset(5)
        }
    }

    // MARK: - User actions

    @objc
    private func addButtonTapped() {
        HapticTouch.generateLight()
        delegate?.addButtonTapped()
    }

    @objc
    private func cookModeButtonTapped() {
        HapticTouch.generateSuccess()
        delegate?.navigateToStepByStepMode()
    }

    @objc
    private func commentTFTapped() {
        delegate?.textFieldTapped()
    }
}
