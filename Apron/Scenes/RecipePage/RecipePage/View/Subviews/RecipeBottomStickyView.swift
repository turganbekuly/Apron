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
    func saveButtonTapped()
    func textFieldTapped()
    func navigateToStepByStepMode()
}

final class RecipeBottomStickyView: View {
    // MARK: - Properties

    weak var delegate: BottomStickyViewDelegate?
    private var isSaved = false {
        didSet {
            if isSaved { configureSavedButton() }
        }
    }

    // MARK: - Views factory

    private lazy var textField: RoundedTextField = {
        let textField = RoundedTextField(placeholder: "Оставьте ваш отзыв")
        textField.textField.isUserInteractionEnabled = false
        return textField
    }()

    private lazy var addButton: NavigationButton = {
        let button = NavigationButton()
        button.backgroundType = .whiteBackground
        button.setTitle("Добавить в корзину", for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 19
        button.clipsToBounds = true
        return button
    }()

    private lazy var saveButton: NavigationButton = {
        let button = NavigationButton()
        button.backgroundType = .greenBackground
        button.setTitle("Сохранить", for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 19
        button.clipsToBounds = true
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        button.setImage(APRAssets.recipeFavoriteIcon.image, for: .normal)
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
            saveButton
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

        saveButton.snp.makeConstraints {
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
    private func saveButtonTapped() {
        guard !isSaved else {
            delegate?.navigateToStepByStepMode()
            return
        }
        HapticTouch.generateSuccess()
        delegate?.saveButtonTapped()
    }

    @objc
    private func commentTFTapped() {
        delegate?.textFieldTapped()
    }

    // MARK: - Private methods

    private func configureSavedButton() {
        guard !isSaved else {
            saveButton.setTitle("Режим готовки", for: .normal)
            saveButton.setImage(APRAssets.recipePlayIcon.image.withRenderingMode(.alwaysTemplate), for: .normal)
            saveButton.tintColor = .white
            saveButton.setImage(nil, for: .highlighted)
            return
        }
        // MARK: - TODO SAVED/UNSAVED FLOW
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.setImage(APRAssets.favoriteIcon24.image.withTintColor(.white), for: .normal)
    }

    // MARK: - Public methods

    func configure(isSaved: Bool) {
        self.isSaved = isSaved
    }
}
