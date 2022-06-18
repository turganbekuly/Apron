//
//  TabBarViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import Protocols
import RemoteConfig

protocol TabBarDisplayLogic: AnyObject {
    
}

final class TabBarViewController: AppTabBarController {
    // MARK: - Properties

    var state: State {
        didSet {
            updateState()
        }
    }

    lazy var pendingDeeplinkProvider = DeeplinkServicesContainer.shared.pendingDeeplinkProvider

    enum ViewControllerTypes {
        case main
        case search
        case saved
    }

    private lazy var mainModule = MainBuilder(state: .initial).build()
    private lazy var searchModule = SearchBuilder(state: .initial(.general)).build()
    private lazy var favouriteModule = SavedRecipesBuilder(state: .initial).build()

    // MARK: - Init
    
    init(state: State) {
        self.state = state

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Life Cycle
    
    override  func viewDidLoad() {
        super.viewDidLoad()
        state = { state }()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleRemoteConfig()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        configureColors()
    }
    
    // MARK: - Methods

    func configureTabBar() {

        viewControllers = [
            configureViewController(viewController: mainModule, type: .main),
            configureViewController(viewController: searchModule, type: .search),
            configureViewController(viewController: favouriteModule, type: .saved)
        ]
    }

    private func configureViewController(viewController: UIViewController, type: ViewControllerTypes) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: viewController)
        switch type {
        case .main:
            navigationController.tabBarItem.title = L10n.TabBar.Home.title
            navigationController.tabBarItem.image = ApronAssets.tabHomeSelectedIcon.image
        case .search:
            navigationController.tabBarItem.title = L10n.TabBar.Search.title
            navigationController.tabBarItem.image = ApronAssets.navSearchIcon.image
        case .saved:
            navigationController.tabBarItem.title = L10n.TabBar.Saved.title
            navigationController.tabBarItem.image = ApronAssets.tabFaveSelectedIcon.image
        }
        return navigationController
    }

    private func configureColors() {
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
    
}
