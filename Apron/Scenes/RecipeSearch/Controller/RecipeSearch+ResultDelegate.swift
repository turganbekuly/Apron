//
//  RecipeSearch+ResultDelegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 08.12.2022.
//

import Foundation

extension RecipeSearchViewController: RecipeSearchCellProtocol {
    func saveRecipeTapped(with id: Int) {
        interactor.saveRecipe(request: .init(id: id))
    }

    func navigateToAuthFromRecipe() {
        handleAuthorizationStatus { }
    }

    func navigateToRecipe(with id: Int) {
        let viewContoller = RecipePageBuilder(state: .initial(id: id, .search)).build()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewContoller, animated: true)
        }
    }

    func cartItemsAdded() {
        show(
            type: .regular("Ингредиенты добавлены в корзину", "Посмотреть"),
            firstAction:  {
                let viewController = ShoppingListBuilder(state: .initial(.regular)).build()
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(viewController, animated: false)
                }
            }
        )
    }
}

extension RecipeSearchViewController: RecipeSearchCellV2Protocol {
    func saveRecipeTappedv2(with id: Int) {
        saveRecipe(with: id)
    }

    func navigateToAuthFromRecipev2() {
        handleAuthorizationStatus { }
    }

    func navigateToRecipev2(with id: Int) {
        let viewContoller = RecipePageBuilder(state: .initial(id: id, .search)).build()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewContoller, animated: true)
        }
    }
}

