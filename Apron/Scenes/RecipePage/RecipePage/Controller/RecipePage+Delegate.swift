//
//  RecipePage+Delegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 24.05.2022.
//

import UIKit
import Storages
import Models

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

    func textFieldTapped() {
//        show(type: .error("Функция добавления отзыва скоро будет готова!"))
        var body = AddCommentRequestBody()
        body.recipeId = recipe?.id
        let viewController = AddCommentBuilder(state: .initial(recipe?.id, body)).build()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension RecipePageViewController: CreateActionFlowProtocol {
    func handleChosenAction(type: CreateActionType) {
        switch type {
        case .shoppingList:
            guard let ingredients = recipe?.ingredients else { return }
            let cartItems: [CartItem] = ingredients.map {
                CartItem(
                    productId: $0.product?.id ?? 0,
                    productName: $0.product?.name ?? "",
                    productCategoryName: $0.product?.productCategoryName ?? "",
                    productImage: $0.product?.image,
                    amount: $0.amount ?? 0,
                    measurement: $0.measurement ?? "",
                    recipeName: [self.recipe?.recipeName ?? ""],
                    bought: false
                )
            }

            let viewController = PreShoppingListBuilder(state: .initial(cartItems, self)).build()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        default:
            break
        }
    }
}

extension RecipePageViewController: PreShoppingListDismissedDelegate {
    func dismissedWithIngredients() {
        show(
            type: .regular("Ингредиенты добавлены в корзину", "Посмотреть"),
            firstAction:  {
                let viewController = ShoppingListBuilder(state: .initial).build()
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            }
        )
    }

    func dismissed() {
        //
    }
}
