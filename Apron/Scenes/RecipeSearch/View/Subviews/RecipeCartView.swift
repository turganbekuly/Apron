//
//  RecipeCartView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 08.12.2022.
//

import UIKit
import APRUIKit
import Storages
import NVActivityIndicatorView

protocol RecipeCartViewDelegate: AnyObject {
    func cartViewTapped()
}

public final class RecipeCartView: UIView {
    // MARK: - Properties

    weak var delegate: RecipeCartViewDelegate?
    private var isLoading = false

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
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        view.layer.borderWidth = 0.5
        view.layer.borderColor = ApronAssets.primaryTextMain.color.cgColor
        return view
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cart.fill.badge.plus")
        imageView.tintColor = ApronAssets.primaryTextMain.color
        return imageView
    }()

    private lazy var ingredientsCountLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.medium12
        label.textColor = ApronAssets.primaryTextMain.color
        label.textAlignment = .center
        return label
    }()

    private lazy var activityIndicator = NVActivityIndicatorView(
        frame: .zero,
        type: .ballRotateChase,
        color: ApronAssets.primaryTextMain.color,
        padding: nil
    )

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        [containerView, activityIndicator].forEach { addSubviews($0) }
        [imageView, ingredientsCountLabel].forEach { containerView.addSubviews($0) }
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(counterTapped))
        containerView.addGestureRecognizer(tapGR)
        activityIndicator.isHidden = true
        activityIndicator.alpha = 0.0
        setupConstraints()
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(8)
            $0.size.equalTo(20)
        }

        ingredientsCountLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(8)
            $0.leading.equalTo(imageView.snp.trailing).offset(4)
        }

        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(18)
        }
    }

    // MARK: - User actions

    @objc
    private func counterTapped() {
        startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.delegate?.cartViewTapped()
            self.stopAnimating()
        }
    }

    // MARK: - Public methods

    func configure(ingredients count: Int) {
        ingredientsCountLabel.text = "\(count) ИНГРЕДИЕНТОВ"
    }

    func startAnimating() {
        isLoading = true
        isUserInteractionEnabled = false

        activityIndicator.isHidden = false
        activityIndicator.startAnimating()

        UIView.animate(withDuration: 0.25) {
            self.imageView.alpha = 0.0
            self.ingredientsCountLabel.alpha = 0.0
            self.activityIndicator.alpha = 1.0
        }
    }

    func stopAnimating() {
        isLoading = false

        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak self] in
            guard let self = self else { return }
            self.isUserInteractionEnabled = true
        }
        CATransaction.setAnimationDuration(0.15)

        self.activityIndicator.alpha = 0.0
        self.imageView.alpha = 1.0
        self.ingredientsCountLabel.alpha = 1.0
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = false

        CATransaction.commit()
    }
}
