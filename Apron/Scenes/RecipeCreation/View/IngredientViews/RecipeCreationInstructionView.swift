//
//  RecipeCreationInstructionView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 23.04.2022.
//

import UIKit
import DesignSystem
import Models

final class RecipeCreationInstructionView: UIView {
    // MARK: - Properties

    var onItemDelete: (() -> Void)?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
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
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()

    private lazy var instructionLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold12
        label.textColor = .black
        label.numberOfLines = 0
        label.sizeToFit()
        label.textAlignment = .left
        return label
    }()

    private lazy var stepLabel: UILabel = {
        let label = UILabel()
        label.textColor = Assets.gray.color
        label.font = TypographyFonts.regular14
        return label
    }()

    private lazy var removeButton: UIButton = {
        let button = UIButton()
        button.setImage(Assets.trashIcon.image, for: .normal)
        button.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var imageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()

    // MARK: - Setup Views

    private func setupViews() {
        addSubviews(containerView, stepLabel)
        [instructionLabel, removeButton, imageStackView].forEach {
            containerView.addSubview($0)
        }
        setupConstraints()
    }

    private func setupConstraints() {
        stepLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }

        containerView.snp.makeConstraints {
            $0.top.equalTo(stepLabel.snp.bottom).offset(4)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        removeButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(24)
        }

        instructionLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(removeButton.snp.leading).offset(-8)
        }

        imageStackView.snp.makeConstraints {
            $0.top.equalTo(instructionLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(8)
        }
    }

    // MARK: - User actions

    @objc
    private func removeButtonTapped() {
        //
    }

    // MARK: - Methods

    func configure(instruction: String, image: UIImage?) {
        instructionLabel.text = instruction
        stepLabel.text = "1 шаг"
        guard let image = image else {
            return
        }
        imageStackView.removeAllArrangedSubviews()
        imageView.image = image
        imageStackView.addArrangedSubview(imageView)
    }
}
