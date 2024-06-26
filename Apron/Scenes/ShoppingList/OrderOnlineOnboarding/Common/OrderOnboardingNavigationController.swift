//
//  OrderOnboardingNavigationController.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 21.08.2023.
//

import APRUIKit
import UIKit
import Storages

public final class OrderOnboardingNavigationController: UINavigationController {

    // MARK: - Window

    override public var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }

    override public var shouldAutorotate: Bool {
        false
    }

    // MARK: - Views

    private lazy var closeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: APRAssets.iconNavigationClose.image,
            style: .plain,
            target: self,
            action: #selector(didTappedClose(_:))
        )
        return button
    }()

    // MARK: - Init

    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        configure()
    }

    override public init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)

        configure()
    }

    public required init?(coder aDecoder: NSCoder) {
        nil
    }

    // MARK: - Life Cycle

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureColors()
    }

    override public func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.backButtonTitle = " "
        viewController.navigationItem.rightBarButtonItem = closeButton
        super.pushViewController(viewController, animated: animated)
    }

    override public func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        viewControllers.first?.navigationItem.backButtonTitle = " "
        viewControllers.first?.navigationItem.rightBarButtonItem = closeButton
        super.setViewControllers(viewControllers, animated: animated)
    }

    // MARK: - Methods

    @objc
    private func didTappedClose(_ sender: UIBarButtonItem) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if self.presentingViewController != nil {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.popToRootViewController(animated: true)
            }
        }
    }

    private func configure() {
        navigationBar.topItem?.rightBarButtonItem = closeButton
        navigationBar.shadowImage = UIImage()

        configureColors()
    }

    private func configureColors() {
        closeButton.tintColor = APRAssets.gray.color.withAlphaComponent(0.32)
        navigationBar.barTintColor = APRAssets.secondary.color
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = APRAssets.secondary.color
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            appearance.shadowColor = .clear

            navigationBar.standardAppearance = appearance
            navigationBar.compactAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        }
        view.backgroundColor = APRAssets.secondary.color
    }

}

