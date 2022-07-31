//
//  MessageView.swift
//  AKNetwork
//
//  Created by Akarys Turganbekuly on 13.01.2022.
//

import APRUIKit
import UIKit
import SnapKit
import Lottie

@available(iOS 13.0, *)
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
        case .error, .success:
            return [iconImageView]
        case .regular:
            return [firstButton]
        case .loader:
            return [animationView]
        case .forceUpdate:
            return [subtitleLabel, firstButton, iconImageView]
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
        case .error, .success:
            iconImageView.image = viewModel.icon
        case .regular:
            firstButton.setAttributedTitle(viewModel.firstButtonTitle, for: .normal)
        case .loader:
            addShadow(offset: .zero, radius: 50, opacity: 1)
        case .forceUpdate:
            subtitleLabel.attributedText = viewModel.subtitle
            iconImageView.image = viewModel.icon
            firstButton.setAttributedTitle(viewModel.firstButtonTitle, for: .normal)
            firstButton.setBackgroundColor(ApronAssets.colorsYello.color, for: .normal)
            firstButton.layer.cornerRadius = 28
            firstButton.clipsToBounds = true
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
        case .success, .error:
            makeSuccessConstraints()
        case .regular:
            makeRegularConstraints()
        case .loader:
            makeLoaderConstraints()
        case .forceUpdate:
            makeForceUpdateConstraints()
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

    private func makeRegularConstraints() {
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        headerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        firstButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(firstButton.snp.leading).offset(-8)
            make.bottom.equalToSuperview().inset(16)
        }
    }

    private func makeLoaderConstraints() {
        animationView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func makeForceUpdateConstraints() {
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        headerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
        }
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(200)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        firstButton.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
            make.height.equalTo(56)
        }
    }

    private func configureColors() {
        headerView.backgroundColor = colorBackground
        titleLabel.textColor = colorTitle
        switch type {
        case .dialog, .forceUpdate:
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
