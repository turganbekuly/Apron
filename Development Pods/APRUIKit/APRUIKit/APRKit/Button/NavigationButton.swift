//
//  NavigationButton.swift
//  APRUIKit
//
//  Created by Akarys Turganbekuly on 12.06.2022.
//

import UIKit
import NVActivityIndicatorView
import SnapKit

public final class NavigationButton: Button {
    // MARK: - Public properties

    public enum ButtonType {
        case blackBackground
        case whiteBackground
        case yelloBackground
    }

    public var backgroundType: ButtonType = .blackBackground {
        didSet {
            switch backgroundType {
            case .blackBackground:
                applyStyle(PrimaryButtonBlackStyle.self)
                activityIndicator.color = .white
            case .whiteBackground:
                applyStyle(PrimaryButtonWhiteStyle.self)
                activityIndicator.color = .black
            case .yelloBackground:
                applyStyle(PrimaryButtonYellowStyle.self)
                activityIndicator.color = .black
            }
        }
    }

    public var isImageVisible = false {
        didSet {
            customImageView.isHidden = !isImageVisible
        }
    }

    public var showShadow = true {
        didSet {
            hideShadow()
        }
    }

    // MARK: - UI Elements

    private lazy var activityIndicator = NVActivityIndicatorView(
        frame: .zero,
        type: .circleStrokeSpin,
        color: .white,
        padding: nil
    )

    private lazy var customImageView = UIImageView(image: ApronAssets.arrowForward.image)

    // MARK: - Private properties

    private var isLoading = false
    private var image: UIImage?

    // MARK: - Init

    public init(image: UIImage? = nil) {
        super.init(frame: .zero)
        applyStyle(PrimaryButtonBlackStyle.self)
        if let image = image {
            customImageView.image = image
        }
        setupViews()
        setupConstraints()
    }

    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        applyStyle(PrimaryButtonBlackStyle.self)
        setupViews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Configuration

    func setupViews() {
        clipsToBounds = false
        layer.shadowColor = UIColor
            .black
            .withAlphaComponent(0.2)
            .cgColor
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowOpacity = 1
        layer.shadowRadius = 24
        addSubviews(customImageView, activityIndicator)
        customImageView.isHidden = !isImageVisible
        activityIndicator.isHidden = true
        activityIndicator.alpha = 0.0
    }

    func hideShadow() {
        layer.shadowOpacity = 0
    }

    func setupConstraints() {
        if let label = titleLabel {
            customImageView.snp.makeConstraints {
                $0.trailing.equalTo(label.snp.leading).offset(-8)
                $0.centerY.equalTo(snp.centerY)
                $0.size.equalTo(24)
            }
        } else {
            customImageView.snp.makeConstraints {
                $0.trailing.equalTo(snp.trailing).offset(-8)
                $0.centerY.equalTo(snp.centerY)
                $0.size.equalTo(24)
            }
        }

        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(14)
        }
    }

    // MARK: - Public methods

    public func startAnimating() {
        activityIndicator.color = titleLabel?.textColor ?? .white

        isLoading = true
        isUserInteractionEnabled = false

        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        image = imageView?.image

        UIView.animate(withDuration: 0.25) {
            self.setImage(nil, for: .init())
            self.titleLabel?.alpha = 0.0
            self.customImageView.alpha = 0.0
            self.activityIndicator.alpha = 1.0
        }
    }

    public func stopAnimating() {
        isLoading = false

        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak self] in
            guard let self = self else { return }
            self.isUserInteractionEnabled = true
        }
        CATransaction.setAnimationDuration(0.15)

        self.activityIndicator.alpha = 0.0
        self.setImage(self.image ?? self.imageView?.image, for: .init())
        self.titleLabel?.alpha = 1.0
        self.customImageView.alpha = 1.0
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = false

        CATransaction.commit()
    }
}

