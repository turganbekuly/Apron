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
import AlertMessages
import Models
import Storages

protocol TabBarDisplayLogic: AnyObject {

}

final class TabBarViewController: AppTabBarController {
    // MARK: - Private properties

    private lazy var cartManager = CartManager.shared

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
        case mealPlanner
    }

    private lazy var mainModule = MainBuilder(state: .initial).build()
    private lazy var searchModule = SearchBuilder(state: .initial(.general)).build()
    private lazy var favouriteModule = SavedRecipesBuilder(state: .initial(.tab)).build()
    private lazy var shoppingListModule = ShoppingListBuilder(state: .initial(.tab)).build()
    private lazy var mealPlannerModule = MealPlannerBuilder(state: .initial).build()

    // MARK: - Init

    init(state: State) {
        self.state = state

        super.init(nibName: nil, bundle: nil)

        CartManager.shared.subscribe(self) { [weak self] in
            self?.updateCount()
        }
    }

    required init?(coder: NSCoder) {
        return nil
    }

    // MARK: - Life Cycle

    override  func viewDidLoad() {
        super.viewDidLoad()
        state = { state }()
        self.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
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
            configureViewController(viewController: favouriteModule, type: .saved),
//            configureViewController(viewController: shoppingListModule, type: .shoppingList)
            configureViewController(viewController: mealPlannerModule, type: .mealPlanner)
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
//        case .shoppingList:
//            navigationController.tabBarItem.title = L10n.TabBar.ShoppingList.title
//            navigationController.tabBarItem.image = ApronAssets.tabListSelectedIcon.image
        case .mealPlanner:
            navigationController.tabBarItem.title = L10n.TabBar.MealPlanner.title
            navigationController.tabBarItem.image = ApronAssets.tabPlannerSelectedIcon.image
        }
        return navigationController
    }

    private func configureColors() {
    }

    deinit {
        NSLog("deinit \(self)")
        cartManager.unsubscribe(self)
    }

    // MARK: - Private methods

    private func updateCount() {
        let count = cartManager.itemsCount()
        tabBarItem.badgeValue = count > 0 ? "\(count)" : ""
        tabBarItem.badgeColor = count > 0 ? ApronAssets.mainAppColor.color : .clear
        tabBarItem.setBadgeTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(
        _ tabBarController: UITabBarController,
        shouldSelect viewController: UIViewController
    ) -> Bool {
        guard let index = self.viewControllers?.firstIndex(of: viewController) else { return false }
        if index == 2 || index == 3 {
            handleAuthorizationStatus {
                self.selectedIndex = index
            }
            return false
        }
        self.selectedIndex = index
        return false
    }
}
