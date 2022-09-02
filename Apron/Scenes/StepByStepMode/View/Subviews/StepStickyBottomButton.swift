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
        case timer(counter: String)
        case ingredient
    }

    // MARK: - Views factory

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 17
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
        case .timer(let counter):
            counterLabel.text = counter
            imageView.image = UIImage(systemName: "timer")
            imageView.tintColor = .white
        case .ingredient:
            counterLabel.text = "Игредиенты"
            imageView.image = ApronAssets.recipeIngredientPlaceholder.image
            imageView.tintColor = .gray
        }
    }
}
