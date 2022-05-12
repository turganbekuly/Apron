//
//  MessageView.swift
//  AKNetwork
//
//  Created by Akarys Turganbekuly on 13.01.2022.
//

import DesignSystem
import UIKit
import SnapKit
import Lottie

public class MessageView: UIView {

    // MARK: - Properties

    public var didTappedFirstButton: (() -> Void)?
    public var didTappedSecondButton: (() -> Void)?
    private let type: MessageType
    private var colorBackground: UIColor?
    private var colorTitle: UIColor?
    private var colorSubtitle: UIColor?
    private var colorIcon: UIColor?
    private let animationsList: [String] = [
        "french_fries", "walking_taco",
        "mushroom_bros", "walking_avocado",
        "walking_broccoli", "walking_cup",
        "walking_donut", "walking_orange"
    ]

    // MARK: - Views

    private lazy var blurView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()

    private lazy var headerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()

    lazy var animationView: AnimationView = {
        let animation = Animation.makeFromBundle(name: animationsList.randomElement() ?? "")
        let animationView = AnimationView(animation: animation)
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        animationView.backgroundBehavior = .stop
        animationView.play()
        return animationView
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating()
        return loadingIndicator
    }()

    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        return view
    }()

    private lazy var subtitleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        return view
    }()

    private lazy var firstButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(firstButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var secondButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(secondButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var optionalViews: [UIView] = {
        switch type {
        case .dialog:
            return [subtitleLabel, firstButton, secondButton]
        case .error, .regular, .success:
            return [iconImageView]
        case .loader:
            return [animationView]
        }
    }()

    // MARK: - Init

    public init(type: MessageType) {
        self.type = type

        super.init(frame: .zero)

        configure()
    }

    required init?(coder: NSCoder) {
        nil
    }

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureColors()
    }

    // MARK: - Methods

    @objc
    private func firstButtonTapped(_ sender: UIButton) {
        didTappedFirstButton?()
    }

    @objc
    private func secondButtonTapped(_ sender: UIButton) {
        didTappedSecondButton?()
    }

    public func configure(with viewModel: MessageProtocol) {
        titleLabel.attributedText = viewModel.title
        switch type {
        case .dialog:
            subtitleLabel.attributedText = viewModel.subtitle
            firstButton.setAttributedTitle(viewModel.firstButtonTitle, for: .normal)
            secondButton.setAttributedTitle(viewModel.secondButtonTitle, for: .normal)
        case .error, .regular, .success:
            iconImageView.image = viewModel.icon
        case .loader:
            addShadow(offset: .zero, radius: 50, opacity: 1)
        }
        colorBackground = viewModel.backgroundColor
        colorTitle = viewModel.titleColor
        colorSubtitle = viewModel.subtitleColor
        colorIcon = viewModel.iconColor

        configureColors()
    }

    private func configure() {
        clipsToBounds = true
        layer.cornerRadius = 8

        configureUserInterface()
        configureViews()
        configureColors()
        makeConstraints()
    }

    private func configureViews() {
        ([blurView, headerView, titleLabel] + optionalViews).forEach {
            addSubview($0)
        }
    }

    private func makeConstraints() {
        switch type {
        case .dialog:
            makeDialogConstraints()
        case .success, .regular, .error:
            makeSuccessConstraints()
        case .loader:
            makeLoaderConstraints()
        }
    }

    private func makeDialogConstraints() {
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        headerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        firstButton.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
            make.height.equalTo(40)
        }
        secondButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(firstButton.snp.centerY)
            make.height.equalTo(firstButton.snp.height)
        }
    }

    private func makeSuccessConstraints() {
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        headerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalTo(iconImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }

    private func makeLoaderConstraints() {
        animationView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func configureColors() {
        headerView.backgroundColor = colorBackground
        titleLabel.textColor = colorTitle
        switch type {
        case .dialog:
            subtitleLabel.textColor = colorSubtitle
        case .error, .regular, .success:
            iconImageView.tintColor = colorIcon
        case .loader:
            layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        }
    }

    private func configureUserInterface() {
        if #available(iOS 13.0, *) {
            if let userInterfaceStyle = UIApplication.shared.windows.first?.overrideUserInterfaceStyle {
                overrideUserInterfaceStyle = userInterfaceStyle
            }
        }
    }

}

// MARK: - Animation Extension
private extension Animation {
    static func makeFromBundle(name: String) -> Animation? {
        return make(name: name, classForModuleBundle: BundleToken.self, bundleName: "AlertMessages-Assets")
    }

    private static func make(name: String, classForModuleBundle: AnyClass, bundleName: String) -> Animation? {
        guard let bundlePath = Bundle(for: classForModuleBundle).path(forResource: bundleName, ofType: "bundle") else { return nil }
        guard let bundle = Bundle(path: bundlePath) else { return nil }
        guard let path = bundle.path(forResource: name, ofType: "json") else { return nil }
        return Animation.filepath(path)
    }
}

class BundleToken {}
