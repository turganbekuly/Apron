//
//  Filter+ActionButtons.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 18.10.2022.
//

import Foundation
import Models

extension FiltersViewController: FilterActionButtonProtocol {
    func actionButtonTapped(with type: FilterAddButtonType) {
        switch type {
        case .ingredients:
            let vc = IngredientSelectionBuilder(state: .initial(self, .onlyItem)).build()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(vc, animated: true)
            }

        case .cuisines:
            break
        }
    }
}

extension FiltersViewController: IngredientSelectedProtocol {
    func onIngredientSelected(ingredient: RecipeIngredient) {
        print(ingredient)
    }
}
