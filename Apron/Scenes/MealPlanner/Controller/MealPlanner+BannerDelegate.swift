//
//  MealPlanner+BannerDelegate.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 13.10.2023.
//

import UIKit

extension MealPlannerViewController: MealPlannerOnboardingCellProtocol {

    func showOnboarding() {
        let vc = OrderOnlineOnboardingViewController(type: .mealPlanner)
        let navController = OrderOnboardingNavigationController(rootViewController: vc)
        DispatchQueue.main.async {
            navController.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                self.navigationController?.present(navController, animated: true)
            }
        }
    }
}
