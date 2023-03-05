//
//  RecipeCreationNavigationController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.10.2022.
//

import APRUIKit
import UIKit
import Storages

public final class RecipeCreationNavigationController: UINavigationController {

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
            image: ApronAssets.iconNavigationClose.image.withRenderingMode(.alwaysOriginal),
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
        viewController.navigationItem.leftBarButtonItem = closeButton
        super.pushViewController(viewController, animated: animated)
    }

    override public func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        viewControllers.first?.navigationItem.leftBarButtonItem = closeButton
        super.setViewControllers(viewControllers, animated: animated)
    }

    // MARK: - Methods

    @objc
    private func didTappedClose(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(
            title: "Вы действительно хотите закрыть создание рецепта?",
            message: nil,
            preferredStyle: .alert
        )
        let yesAction = UIAlertAction(title: "Да", style: .default) { [weak self] _ in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                if self.presentingViewController != nil {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.popToRootViewController(animated: true)
                }
            }
        }
        let noAction = UIAlertAction(title: "Нет", style: .cancel)
        [yesAction, noAction].forEach {
            alert.addAction($0)
        }
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }

    private func configure() {
        navigationBar.topItem?.rightBarButtonItem = closeButton
        navigationBar.shadowImage = UIImage()

        configureColors()
    }

    private func configureColors() {
        navigationBar.barTintColor = ApronAssets.secondary.color
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = ApronAssets.secondary.color
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            appearance.shadowColor = .clear

            navigationBar.standardAppearance = appearance
            navigationBar.compactAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        }
        view.backgroundColor = ApronAssets.secondary.color
    }

}
