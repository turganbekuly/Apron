//
//  CaloriesView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 06.03.2022.
//

import UIKit
import DesignSystem

final class CaloriesView: UIView {
    // MARK: - Init

    init() {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ApronAssets.calLowIcon.image
        return imageView
    }()

    private lazy var caloriesAmountLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold18
        label.textColor = .black
        return label
    }()

    // MARK: - Setup Views

    private func setupViews() {
        [imageView, caloriesAmountLabel].forEach { addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {

    }
}
