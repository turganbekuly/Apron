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
        name: String,
        measurement: String
    ) {
        super.init(frame: .zero)

        self.nameLabel.text = name
        self.measureScopeLabel.text = measurement

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular16
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private lazy var measureScopeLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.bold16
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        [nameLabel, measureScopeLabel].forEach { addSubviews($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(38)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.leading.equalToSuperview()
            $0.trailing.lessThanOrEqualTo(snp.centerX)
            $0.bottom.equalToSuperview().inset(4)
        }

        measureScopeLabel.snp.makeConstraints {
            $0.centerY.equalTo(nameLabel.snp.centerY)
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(snp.centerX).offset(16)
        }
    }

    // MARK: - Public methods

    func changeService(newMeasure: String) {
        measureScopeLabel.text = newMeasure
    }
}
