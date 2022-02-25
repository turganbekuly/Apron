//
//  CartButtonView.swift
//  DesignSystem
//
//  Created by Akarys Turganbekuly on 22.02.2022.
//

import UIKit
import DesignSystem

public final class CartButtonView: UIView {
    // MARK: - Public properties

    var onTap: (() -> Void)?

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .black
        return view
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.navCartIconFilled.image
        return imageView
    }()

    private lazy var itemCounterLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular14
        label.textColor = .white
        label.text = "35"
        return label
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        [containerView].forEach { addSubviews($0) }
        [imageView, itemCounterLabel].forEach { containerView.addSubviews($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(50)
            $0.height.equalTo(30)
        }
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        imageView.snp.makeConstraints {
            $0.size.equalTo(18)
            $0.leading.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
        }

        itemCounterLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(imageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(8)
        }
    }
}
