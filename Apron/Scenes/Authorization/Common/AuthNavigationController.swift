//
//  AuthNavigationController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20.05.2022.
//

import UIKit
import DesignSystem

final class AuthNavigationController: UINavigationController {
    // MARK: - Window

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var shouldAutorotate: Bool {
        return false
    }

    // MARK: - Init

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        setupViews()
    }

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)

        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.backButtonTitle = " "
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: skipButton)
        super.pushViewController(viewController, animated: animated)
    }

    // MARK: - Views factory

    private lazy var skipButton: BlackOpButton = {
        let button = BlackOpButton(arrowState: .none, frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        button.setTitle("Пропустить", for: .normal)
        button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()

    // MARK: - Setup Views

    private func setupViews() {
        navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(customView: skipButton)
        navigationBar.shadowImage = UIImage()
    }

    // MARK: - User actions

    @objc
    private func skipButtonTapped() {
        let alert = UIAlertController(
            title: "Вы действительно хотите пропустить?",
            message: "Вы пропустите персонализированный контент и сохранение наших вкусных рецептов.",
            preferredStyle: .alert
        )
        let yesAction = UIAlertAction(title: "Да", style: .default) { [weak self] _ in
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else { return }

                if self.presentingViewController != nil {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.popToRootViewController(animated: true)
                }
            }
        }
        let noAction = UIAlertAction(title: "Нет", style: .cancel)
        [noAction, yesAction].forEach {
            alert.addAction($0)
        }
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
}
