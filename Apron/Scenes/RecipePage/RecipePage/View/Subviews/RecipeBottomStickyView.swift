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
}

final class RecipeBottomStickyView: View {
    // MARK: - Properties

    weak var delegate: BottomStickyViewDelegate?

    // MARK: - Views factory

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private lazy var textField: RoundedTextField = {
        let textField = RoundedTextField(placeholder: "Оставьте ваш комментарий")
        textField.textField.isUserInteractionEnabled = false
        return textField
    }()

    private lazy var addButton: BlackOpButton = {
        let button = BlackOpButton()
        button.setTitle("Добавить в корзину", for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 19
        button.clipsToBounds = true
        return button
    }()

    private lazy var saveButton: BlackOpButton = {
        let button = BlackOpButton()
        button.setTitle("Сохранить", for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 19
        button.clipsToBounds = true
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        button.setImage(ApronAssets.recipeFavoriteIcon.image, for: .normal)
        return button
    }()

    // MARK: - Setup views

    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
        addSubviews(
            addButton,
            saveButton
        )
    }

    override func setupConstraints() {
        super.setupConstraints()

        addButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(16)
            $0.height.equalTo(38)
            $0.trailing.equalTo(snp.centerX).offset(-5)
        }

        saveButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(16)
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
        HapticTouch.generateSuccess()
        delegate?.saveButtonTapped()
    }
}
