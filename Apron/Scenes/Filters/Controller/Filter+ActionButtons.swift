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
        guard let product = ingredient.product, !selectedFilters.ingredients.contains(product) else {
            return
        }

        selectedFilters.ingredients.append(product)
        guard
            let section = sections.firstIndex(where: { $0.section == .ingredients }),
            let row = sections[section].rows.firstIndex(where: { $0 == .ingredient(product) })
        else { return }

        mainView.selectItem(at: IndexPath(row: row, section: section), animated: false, scrollPosition: .centeredHorizontally)
        mainView.reloadData()
    }
}
