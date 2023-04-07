//
//  Main+CookNowDelegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 08.12.2022.
//

import Foundation
import Models

extension MainViewController: CookNowCellProtocol {
    func saveRecipeTappedv2(with id: Int) {
        saveRecipe(with: id)
    }

    func navigateToAuthFromRecipev2() {
        handleAuthorizationStatus { }
    }

    func navigateToRecipev2(with id: Int) {
        let viewContoller = RecipePageBuilder(state: .initial(id: id, .main)).build()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewContoller, animated: true)
        }
    }

    func navigateToSeeAll(with type: CookNowCellType) {
        var searchFilter = SearchFilterRequestBody()
        switch type {
        case .cookNow:
            searchFilter.dayTimeType = [defineRecipeDayTime().rawValue]
        case .eventRecipe:
            searchFilter.eventTypes = [eventType]
        }
        
        let viewController = UINavigationController(
            rootViewController: RecipeSearchBuilder(state: .initial(searchFilter)).build()
        )
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
        DispatchQueue.main.async { [weak self] in
            self?.tabBarController?.selectedIndex = 1
            self?.present(viewController, animated: true)
        }
    }
}
