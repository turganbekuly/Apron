//
//  TabBar+Deeplink.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07.06.2022.
//

import UIKit

extension TabBarViewController: PendingDeeplinkProviderDelegate {
    func pendingDeeplinkProvider(_ provider: PendingDeeplinkProvider, didChangePendingDeeplink deeplink: Deeplink?) {
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
    private func process(_ deeplink: Deeplink) {
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
                navigationController.pushViewController(vc, animated: true)
            }
        case .openSavedRecipes:
            changeTab(for: .openSavedRecipes)
        case .unknown:
            print("Did received unknown")
        }
    }

    private func changeTab(for deeplink: Deeplink) {
        switch deeplink {
        case .openCommunity, .openRecipe, .openShoppingList:
            selectedIndex = 0
        case .openSavedRecipes:
            selectedIndex = 2
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
