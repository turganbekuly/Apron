//
//  StepStickyBottomButton.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 30.08.2022.
//

import UIKit
import APRUIKit

final class StepStickyBottomButton: View {
    // MARK: - Button State

    enum StepStickyButtonState {
        case timer
        case ingredient
        case addComment
    }

    // MARK: - Views factory

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 19
        view.clipsToBounds = true
        return view
    }()

    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = TypographyFonts.regular14
        label.textAlignment = .left
        label.text = "Начать таймер"
        return label
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "timer")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white
        return imageView
    }()

    // MARK: - Setup Views

    override func setupViews() {
        backgroundColor = .clear
        addSubview(containerView)
        containerView.addSubviews(counterLabel, imageView)
    }

    override func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }

        counterLabel.snp.makeConstraints {
            $0.centerY.equalTo(imageView.snp.centerY)
            $0.leading.equalTo(imageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(8)
        }
    }

    // MARK: - Methods

    func configure(with state: StepStickyButtonState) {
        switch state {
        case .timer:
            counterLabel.text = "Начать таймер"
        case .ingredient:
            counterLabel.text = "Игредиенты"
            imageView.image = ApronAssets.recipeIngredientPlaceholder.image.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = .white
        case .addComment:
            counterLabel.text = "Оставить отзыв"
            imageView.image = ApronAssets.cameraIcon.image.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = .white
        }
    }
}
