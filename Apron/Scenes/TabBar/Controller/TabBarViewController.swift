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
import HapticTouch

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
        case createRecipe
        case saved
        case mealPlanner
    }

    private lazy var mainModule = MainBuilder(state: .initial).build()
    private lazy var searchModule = SearchBuilder(state: .initial(.general)).build()
    private lazy var recipeCreationModule = RecipeCreationBuilder(state: .initial(.create(RecipeCreation(), .main))).build()
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
            configureViewController(viewController: recipeCreationModule, type: .createRecipe),
            configureViewController(viewController: favouriteModule, type: .saved),
            configureViewController(viewController: mealPlannerModule, type: .mealPlanner)
        ]
    }

    private func configureViewController(viewController: UIViewController, type: ViewControllerTypes) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: viewController)
        switch type {
        case .main:
            navigationController.tabBarItem.title = L10n.TabBar.Home.title
            navigationController.tabBarItem.image = APRAssets.tabHomeSelectedIcon.image
        case .search:
            navigationController.tabBarItem.title = L10n.TabBar.Search.title
            navigationController.tabBarItem.image = APRAssets.navSearchIcon.image
        case .createRecipe:
            navigationController.tabBarItem.title = L10n.TabBar.RecipeCreation.title
            navigationController.tabBarItem.image = APRAssets.tabAddSelectedIcon.image
        case .saved:
            navigationController.tabBarItem.title = L10n.TabBar.Saved.title
            navigationController.tabBarItem.image = APRAssets.heart24White.image
        case .mealPlanner:
            navigationController.tabBarItem.title = L10n.TabBar.MealPlanner.title
            navigationController.tabBarItem.image = APRAssets.tabPlannerSelectedIcon.image
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
        tabBarItem.badgeColor = count > 0 ? APRAssets.mainAppColor.color : .clear
        tabBarItem.setBadgeTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(
        _ tabBarController: UITabBarController,
        shouldSelect viewController: UIViewController
    ) -> Bool {
        guard let index = self.viewControllers?.firstIndex(of: viewController) else { return false }
        if index == 2 {
            handleAuthorizationStatus {
                let isRecipeCreationEnabled = RemoteConfigManager.shared.configManager.config(for: RemoteConfigKeys.isRecipeCreationEnabled)
                if isRecipeCreationEnabled {
                    self.handleAuthorizationStatus {
                        let vc = RecipeCreationBuilder(state: .initial(.create(RecipeCreation(), .main))).build()
                        let navController = RecipeCreationNavigationController(rootViewController: vc)
                        navController.modalPresentationStyle = .fullScreen
                        HapticTouch.generateSuccess()
                        DispatchQueue.main.async {
                            self.navigationController?.present(navController, animated: true)
                        }
                    }
                } else {
                    self.show(type: .dialog(
                        L10n.Alert.Attention.title,
                        L10n.Alert.RecipeCreation.error,
                        L10n.Alert.Sad.buttonTitle,
                        L10n.Alert.Clear.buttonTitle
                    ))
                }
            }

            return false
        }
        if index == 3 || index == 4 {
            handleAuthorizationStatus {
                self.selectedIndex = index
            }
            return false
        }
        self.selectedIndex = index
        return false
    }
}
