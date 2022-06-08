//
//  TabBar+Deeplink.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07.06.2022.
//

import Foundation

extension TabBarViewController: PendingDeeplinkProviderDelegate {
    func pendingDeeplinkProvider(_ provider: PendingDeeplinkProvider, didChangePendingDeeplink deeplink: Deeplink?) {
        performDeeplink()
    }

    func performDeeplink() {
        guard let deeplink = pendingDeeplinkProvider.pendingDeeplink else { return }

        pendingDeeplinkProvider.pendingDeeplink = nil
//        hidePresentedViewControllerIfNeeded { [weak self] in
//            self?.process(deeplink)
//        }
    }

//    // swiftlint:disable:next function_body_length
//    private func process(_ deeplink: Deeplink) {
//        changeTab(for: deeplink)
//        guard let navigationController = children[safe: selectedIndexPath.row] as? UINavigationController else { return }
//
//        switch deeplink {
//        case .openAds:
//            guard let mainController = navigationController.viewControllers.first(where: { $0 is MainViewController }) as? MainViewController
//            else { return }
//
//            DispatchQueue.main.async {
//                mainController.routeToAds(with: .hidden(Filter()))
//            }
//        case .openPersonalAds:
//            guard let mainController = navigationController.viewControllers.first(where: { $0 is ProfileViewController }) as? ProfileViewController
//            else { return }
//
//            DispatchQueue.main.async {
//                mainController.showPersonalAds(initialState: .main)
//            }
//        case let .openAd(id):
//            guard let mainController = navigationController.viewControllers.first(where: { $0 is MainViewController }) as? MainViewController
//            else { return }
//
//            mainController.setTabBarHidden(true)
//            let controller = AdBuilder(state: .initial(.main, id, [], nil)).build()
//            DispatchQueue.main.async {
//                navigationController.pushViewController(controller, animated: true)
//            }
//        case let .openPersonalAd(id):
//            guard let mainController = navigationController.viewControllers.first(where: { $0 is MainViewController }) as? MainViewController
//            else { return }
//
//            mainController.setTabBarHidden(true)
//            let controller = AdBuilder(state: .initial(.active, id, [], nil)).build()
//            DispatchQueue.main.async {
//                navigationController.pushViewController(controller, animated: true)
//            }
//        case .openFavorites:
//            guard let mainController = navigationController.viewControllers.first(where: { $0 is ProfileViewController }) as? ProfileViewController
//            else { return }
//
//            DispatchQueue.main.async {
//                mainController.showFavorites()
//            }
//        case .openCreateAd:
//            guard let mainController = navigationController.viewControllers.first(where: { $0 is MainViewController }) as? MainViewController
//            else { return }
//
//            DispatchQueue.main.async {
//                mainController.showCreateAd()
//            }
//        case .openSellNow:
//            guard let mainController = navigationController.viewControllers.first(where: { $0 is MainViewController }) as? MainViewController
//            else { return }
//
//            DispatchQueue.main.async {
//                mainController.showSellNow()
//            }
//        case .openBlog:
//            guard let mainController = navigationController.viewControllers.first(where: { $0 is MainViewController }) as? MainViewController
//            else { return }
//
//            DispatchQueue.main.async {
//                mainController.showBlog()
//            }
//        case .openCredit:
//            guard let mainController = navigationController.viewControllers.first(where: { $0 is MainViewController }) as? MainViewController
//            else { return }
//
//            DispatchQueue.main.async {
//                mainController.showCredit()
//            }
//        case .unknown:
//            print("Did received unknown")
//        }
//    }

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
