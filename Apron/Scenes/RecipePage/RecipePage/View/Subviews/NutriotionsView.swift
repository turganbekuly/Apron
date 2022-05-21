//
//  NutriotionsView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21.05.2022.
//

import UIKit
import DesignSystem

final class NutritionsView: UIView {
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var fatView = NutritionView()
    private lazy var proteinView = NutritionView()
    private lazy var carbsView = NutritionView()
    private lazy var firstDivider = SeparatorView()
    private lazy var secondDivider = SeparatorView()

    // MARK: - Setup Views

    private func setupViews() {
        [fatView, proteinView, carbsView, firstDivider, secondDivider].forEach {
            addSubview($0)
        }
        setupConstraints()
    }

    private func setupConstraints() {
        fatView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
        }


    }

    // MARK: - Methods

    func configure() {
    }
}

