//
//  RecipePage+Delegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 24.05.2022.
//

import UIKit
import Storages
import Models

protocol RecipePageCommentAdded: AnyObject {
    func commentDidAdd()
}

extension RecipePageViewController: RecipePageCommentAdded {
    func commentDidAdd() {
        getRecipe(by: recipeId)
        showLoader()
    }
}

extension RecipePageViewController: BottomStickyViewDelegate {
    func navigateToStepByStepMode() {
        guard let instructions = recipe?.instructions else {
            show(type: .error("В рецепте нету инструкции"))
            return
        }
        let vc = StepByStepModeBuilder(
            state: .initial(
                instructions,
                self.recipe?.imageURL,
                self,
                self.recipe?.ingredients ?? []
            )
        ).build()
        let navController = StepNavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            self.navigationController?.present(navController, animated: true)
        }
    }

    func addButtonTapped() {
//        let vc = CreateActionFlowBuilder(state: .initial(.recipePageAddTo, self)).build()
//        DispatchQueue.main.async {
//            self.navigationController?.presentPanModal(vc)
//        }
        handleAddToCart(ingredients: recipe?.ingredients)
    }

    func textFieldTapped() {
        handleAuthorizationStatus() {
            var body = AddCommentRequestBody()
            body.recipeId = self.recipe?.id
            let viewController = AddCommentBuilder(
                state: .initial(self.recipe?.id, body, self)
            ).build()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
}

extension RecipePageViewController: CreateActionFlowProtocol {
    func handleChosenAction(type: CreateActionType) {
        switch type {
        case .shoppingList:
            handleAddToCart(ingredients: recipe?.ingredients)
        default:
            break
        }
    }

    func handleAddToCart(ingredients: [RecipeIngredient]?) {
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
            self.navigationController?.pushViewController(viewController, animated: false)
        }
    }
}

extension RecipePageViewController: PreShoppingListDismissedDelegate {
    func dismissedWithIngredients() {
        show(
            type: .regular("Ингредиенты добавлены в корзину", "Посмотреть"),
            firstAction: {
                let viewController = ShoppingListBuilder(state: .initial(.regular)).build()
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

extension RecipePageViewController: StepByStepFinalStepProtocol {
    func reviewButtonTapped() {
        var body = AddCommentRequestBody()
        body.recipeId = recipe?.id
        let viewController = AddCommentBuilder(state: .initial(recipe?.id, body, self)).build()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
