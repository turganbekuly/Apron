//
//  IngredientView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25.02.2022.
//

import UIKit
import DesignSystem
import Kingfisher

final class IngredientView: UIView {
    // MARK: - Init

    init(
        imageURL: URL?,
        name: String,
        measureScope: String
    ) {
        super.init(frame: .zero)

        self.imageView.kf.setImage(
            with: imageURL,
            placeholder: Assets.testPlaceholderIcon.image
        )
        self.nameLabel.text = name
        self.measureScopeLabel.text = measureScope

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var imageContainerView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 30
        return imageView
    }()

    private lazy var measureScopeLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular16
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.bold16
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    // MARK: - Setup Views

    private func setupViews() {
        [imageView, measureScopeLabel, nameLabel].forEach { addSubviews($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.size.equalTo(45)
        }

        measureScopeLabel.snp.makeConstraints {
            $0.centerY.equalTo(imageView.snp.centerY)
            $0.leading.equalTo(imageView.snp.trailing).offset(24)
            $0.trailing.equalTo(snp.centerX).offset(-16)
        }

        nameLabel.snp.makeConstraints {
            $0.centerY.equalTo(imageView.snp.centerY)
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(snp.centerX).offset(16)
        }
    }

    // MARK: - Public methods

    func changeService(newMeasure: String) {
        measureScopeLabel.text = newMeasure
    }
}
