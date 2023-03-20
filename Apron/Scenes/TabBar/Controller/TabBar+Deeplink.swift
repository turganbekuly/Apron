//
//  TabBar+Deeplink.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07.06.2022.
//

import UIKit
import Models
import RemoteConfig
import HapticTouch

extension TabBarViewController: PendingDeeplinkProviderDelegate {
    func pendingDeeplinkProvider(_ provider: PendingDeeplinkProvider, didChangePendingDeeplink deeplink: CustomDeepLink?) {
        performDeeplink()
    }

    func performDeeplink() {
        guard let deeplink = pendingDeeplinkProvider.pendingDeeplink else { return }

        pendingDeeplinkProvider.pendingDeeplink = nil
        hidePresentedViewControllerIfNeeded { [weak self] in
            self?.process(deeplink)
        }
    }

    // swiftlint:disable:next function_body_length
    private func process(_ deeplink: CustomDeepLink) {
        changeTab(for: deeplink)
        guard let navigationController = children[safe: selectedIndex] as? UINavigationController else { return }

        switch deeplink {
        case .openCommunity(let id):
            guard
                let mainController = navigationController.viewControllers
                    .first(where: { $0 is MainViewController }) as? MainViewController
            else { return }
            let vc = CommunityPageBuilder(state: .initial(.fromMain(id: id))).build()
            mainController.hidesBottomBarWhenPushed = false
            DispatchQueue.main.async {
                navigationController.pushViewController(vc, animated: true)
            }
        case .openRecipe(let id):
            guard
                let mainController = navigationController.viewControllers
                    .first(where: { $0 is MainViewController }) as? MainViewController
            else { return }
            let vc = RecipePageBuilder(state: .initial(id: id, .deeplink)).build()
            mainController.hidesBottomBarWhenPushed = true
            DispatchQueue.main.async {
                navigationController.pushViewController(vc, animated: true)
            }
        case .openShoppingList:
            let vc = ShoppingListBuilder(state: .initial(.regular)).build()
            DispatchQueue.main.async {
                navigationController.pushViewController(vc, animated: false)
            }
        case .openRecipeCreation:
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
                        "Внимание!",
                        "К сожалению, содание рецептов на данный момент недоступно. Администратор приложения временно отключил эту функцию.",
                        "Жаль",
                        "Понятно"
                    ))
                }
            }
        case .openSavedRecipes:
            self.handleAuthorizationStatus {
                self.changeTab(for: .openSavedRecipes)
            }
        case .openMealPlanner:
            self.handleAuthorizationStatus {
                self.changeTab(for: .openMealPlanner)
            }
        case .unknown:
            print("Did received unknown")
        }
    }

    private func changeTab(for deeplink: CustomDeepLink) {
        switch deeplink {
        case .openCommunity, .openRecipe, .openShoppingList, .openRecipeCreation:
            selectedIndex = 0
        case .openSavedRecipes:
            selectedIndex = 3
        case .openMealPlanner:
            selectedIndex = 4
        case .unknown:
            print("Did received unknown")
        }
    }

    private func hidePresentedViewControllerIfNeeded(completion: @escaping () -> Void) {
        guard let presentedViewController = self.presentedViewController else {
            completion()
            return
        }

        DispatchQueue.main.async {
            presentedViewController.dismiss(animated: true, completion: completion)
        }
    }
}
