//
//  NutritionView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21.05.2022.
//

import UIKit
import APRUIKit

final class NutritionView: UIView {
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular12
        label.textColor = ApronAssets.gray.color
        label.textAlignment = .center
        return label
    }()

    private lazy var measureLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold16
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        [typeLabel, measureLabel].forEach {
            addSubview($0)
        }
        setupConstraints()
    }

    private func setupConstraints() {
        typeLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }

        measureLabel.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom).offset(4)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    // MARK: - Methods

    func configure(type: String, measure: String) {
        typeLabel.text = type
        measureLabel.text = measure
    }
}
