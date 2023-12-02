//
//  CartButtonView.swift
//  APRUIKit
//
//  Created by Akarys Turganbekuly on 22.02.2022.
//

import UIKit
import APRUIKit
import Storages

public final class CartButtonView: UIView {
    // MARK: - Private properties

    private lazy var cartManager = CartManager.shared

    // MARK: - Public properties

    var onTap: (() -> Void)?

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        setupViews()

        CartManager.shared.subscribe(self) { [weak self] in
            self?.updateCount()
        }
    }

    deinit {
        cartManager.unsubscribe(self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = APRAssets.primaryTextMain.color
        return view
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cart.fill")
        imageView.tintColor = .white
        return imageView
    }()

    private lazy var itemCounterLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.bold14
        label.textColor = .white
        label.text = "0"
        label.textAlignment = .left
        return label
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        [containerView].forEach { addSubviews($0) }
        [imageView, itemCounterLabel].forEach { containerView.addSubviews($0) }
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(counterTapped))
        containerView.addGestureRecognizer(tapGR)
        updateCount()
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
            $0.centerY.equalToSuperview().offset(2)
            $0.leading.equalTo(imageView.snp.trailing).offset(4)
            $0.trailing.equalToSuperview().inset(8)
        }
    }

    // MARK: - Private methods

    private func updateCount() {
        let count = cartManager.itemsCount()
        itemCounterLabel.text = count.roundedWithAbbreviations
    }

    // MARK: - User actions

    @objc
    private func counterTapped() {
        onTap?()
    }
}
