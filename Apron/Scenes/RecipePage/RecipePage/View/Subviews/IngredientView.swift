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

    override init(frame: CGRect) {
        super.init(frame: frame)
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
        [nameLabel, measureScopeLabel].forEach { addSubviews($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        nameLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.trailing.lessThanOrEqualTo(snp.centerX)
            $0.bottom.equalToSuperview().inset(8)
        }

        measureScopeLabel.snp.makeConstraints {
            $0.centerY.equalTo(nameLabel.snp.centerY)
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(snp.centerX).offset(16)
        }
    }

    // MARK: - Public methods

    func configure(name: String, measurement: String) {
        self.nameLabel.text = name
        self.measureScopeLabel.text = measurement
    }

    func changeService(newMeasure: String) {
        measureScopeLabel.text = newMeasure
    }
}
