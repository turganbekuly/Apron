//
//  SavedRecipes+Delegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05.06.2022.
//

import UIKit

extension SavedRecipesViewController: SavedHeaderActionProtocol {
    func searchBarDidTap() {
        guard !savedRecipes.isEmpty else { return }
        let viewController = UINavigationController(
            rootViewController: GeneralSearchBuilder(
                state: .initial(.savedRecipes)
            ).build()
        )
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
        DispatchQueue.main.async { [weak self] in
            self?.present(viewController, animated: true)
        }
    }
}
