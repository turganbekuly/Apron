//
//  AddSavedRecipes+Delegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.06.2022.
//

import UIKit

extension AddSavedRecipesViewController: SavedHeaderActionProtocol {
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
