//
//  ShoppingList+ActionDelegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 01.07.2022.
//

import UIKit

extension ShoppingListViewController: CreateActionFlowProtocol {
    func handleChosenAction(type: CreateActionType) {
        switch type {
        case .clearIngredients:
            resetCartItems()
        case .shareIngredients:
            shareIngredients(cartItems: cartItems)
        default:
            break
        }
    }
}

extension ShoppingListViewController: CanOrderBannerViewProtocol {
    func closeOrderBanner() {
        UIView.animate(withDuration: 0.4) {
            self.orderBannerViewHeightConstarints?.update(offset: 0)
            self.canOrderBannerView.isHidden = true
            self.view.layoutIfNeeded()
        }
    }
    
    func showOnboarding() {
        let vc = OrderOnlineOnboardingViewController()
        let navController = OrderOnboardingNavigationController(rootViewController: vc)
        DispatchQueue.main.async {
            navController.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                self.navigationController?.present(navController, animated: true)
            }
        }
    }
}
