////
////  ShoppingListBottomStickyView.swift
////  Apron
////
////  Created by Akarys Turganbekuly on 08.12.2022.
////
//
// import UIKit
// import APRUIKit
// import HapticTouch
// import Storages
//
// protocol ShoppingListBottomStickyViewDelegate: AnyObject {
//    func addButtonTapped()
//    func orderButtonTapped()
// }
//
// final class ShoppingListBottomStickyView: View {
//    // MARK: - Properties
//
//    weak var delegate: ShoppingListBottomStickyViewDelegate?
//
//    // MARK: - Views factory
//
//    private lazy var imageView: UIImageView = {
//        let imageView = UIImageView()
//        return imageView
//    }()
//
//    private lazy var textField: RoundedTextField = {
//        let textField = RoundedTextField(placeholder: "Оставьте ваш отзыв")
//        textField.textField.isUserInteractionEnabled = false
//        return textField
//    }()
//
//    private lazy var addButton: BlackOpButton = {
//        let button = BlackOpButton()
//        button.setTitle("Добавить в корзину", for: .normal)
//        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
//        button.layer.cornerRadius = 19
//        button.clipsToBounds = true
//        return button
//    }()
//
//    private lazy var saveButton: BlackOpButton = {
//        let button = BlackOpButton()
//        button.setTitle("Сохранить", for: .normal)
//        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
//        button.layer.cornerRadius = 19
//        button.clipsToBounds = true
//        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
//        button.setImage(ApronAssets.recipeFavoriteIcon.image, for: .normal)
//        return button
//    }()
//
//    // MARK: - Setup views
//
//    override func setupViews() {
//        super.setupViews()
//        backgroundColor = .white
//        textField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(commentTFTapped)))
//        addSubviews(
//            textField,
//            addButton,
//            saveButton
//        )
//    }
//
//    override func setupConstraints() {
//        super.setupConstraints()
//
//        textField.snp.makeConstraints {
//            $0.top.leading.trailing.equalToSuperview().inset(16)
//            $0.height.equalTo(38)
//        }
//
//        addButton.snp.makeConstraints {
//            $0.top.equalTo(textField.snp.bottom).offset(16)
//            $0.leading.equalToSuperview().offset(16)
//            $0.height.equalTo(38)
//            $0.trailing.equalTo(snp.centerX).offset(-5)
//        }
//
//        saveButton.snp.makeConstraints {
//            $0.top.equalTo(textField.snp.bottom).offset(16)
//            $0.trailing.equalToSuperview().offset(-16)
//            $0.height.equalTo(38)
//            $0.leading.equalTo(snp.centerX).offset(5)
//        }
//    }
//
//    // MARK: - User actions
//
//    @objc
//    private func addButtonTapped() {
//        HapticTouch.generateLight()
//        delegate?.addButtonTapped()
//    }
//
//    @objc
//    private func saveButtonTapped() {
//        guard !isSaved else { return }
//        HapticTouch.generateSuccess()
//        configureSavedButton()
////        delegate?.saveButtonTapped()
//    }
//
//    @objc
//    private func commentTFTapped() {
//        delegate?.textFieldTapped()
//    }
//
//    // MARK: - Private methods
//
//    private func configureSavedButton() {
//        saveButton.backgroundType = .greenBackground
//        saveButton.setTitle("Сохранен", for: .normal)
//        saveButton.setImage(ApronAssets.recipeFavoriteIcon.image.withTintColor(.white), for: .normal)
//
//        // For made it flow
////        saveButton.setTitle("Приготовил/а", for: .normal)
////        saveButton.setImage(ApronAssets.checkOvalOutline.image.withTintColor(.black), for: .normal)
//    }
//
//    // MARK: - Public methods
//
//    func configure(isSaved: Bool) {
//        self.isSaved = isSaved
//    }
// }
//
