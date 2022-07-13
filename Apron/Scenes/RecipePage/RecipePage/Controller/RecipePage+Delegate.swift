//
//  RecipePage+Delegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 24.05.2022.
//

import UIKit
import Storages

extension RecipePageViewController: BottomStickyViewDelegate {
    func addButtonTapped() {
        let vc = CreateActionFlowBuilder(state: .initial(.recipePageAddTo, self)).build()
        DispatchQueue.main.async {
            self.navigationController?.presentPanModal(vc)
        }
    }

    func saveButtonTapped() {
        guard let recipe = recipe else { return }
        saveRecipe(with: recipe.id)
    }

    func madeItButtonTapped() {
        //
    }
}

extension RecipePageViewController: CreateActionFlowProtocol {
    func handleChosenAction(type: CreateActionType) {
        switch type {
        case .shoppingList:
            guard let ingredients = recipe?.ingredients else { return }
            let cartManager = CartManager.shared
            cartManager.resetCart()
            ingredients.forEach {
                cartManager.update(productName: $0.product?.name ?? "",
                                   productCategoryName: $0.product?.productCategoryName ?? "",
                                   amount: $0.amount ?? 0,
                                   measurement: $0.measurement ?? "",
                                   recipeName: self.recipe?.recipeName ?? "",
                                   bought: false
                )
            }
            ApronAnalytics.shared.sendAmplitudeEvent(
                .recipeIngredientsAddedToShoppingList(ingredients.map { $0.product?.name ?? "" })
            )
        default:
            break
        }
    }
}
