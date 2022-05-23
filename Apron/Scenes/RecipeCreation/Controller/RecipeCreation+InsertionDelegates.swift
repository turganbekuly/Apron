//
//  RecipeCreation+InsertionDelegates.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.04.2022.
//

import UIKit
import Models

protocol IngredientSelectedProtocol {
    func onIngredientSelected(ingredient: RecipeIngredient)
}

protocol InstructionSelectedProtocol {
    func onInstructionSelected(image: UIImage?, description: String)
}

extension RecipeCreationViewController: IngredientSelectedProtocol {
    func onIngredientSelected(ingredient: RecipeIngredient) {
        recipeCreation?.ingredients.append(ingredient)
        mainView.reloadTableViewWithoutAnimation()
    }
}

extension RecipeCreationViewController: InstructionSelectedProtocol {
    func onInstructionSelected(image: UIImage?, description: String) {
        recipeCreation?.instructions.append(description)
        mainView.reloadTableViewWithoutAnimation()
    }
}

extension RecipeCreationViewController: AddIngredientCellTappedDelegate {
    func onAddIngredientTapped() {
        let viewController = IngredientSelectionBuilder(state: .initial(self)).build()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }

    func onRemoveIngredientTapped(index: Int) {
        recipeCreation?.ingredients.remove(at: index)
        mainView.reloadTableViewWithoutAnimation()
    }
}


extension RecipeCreationViewController: AddInstructionCellTappedDelegate {
    func onRemoveInstructionTapped(index: Int) {
        recipeCreation?.instructions.remove(at: index)
        mainView.reloadTableViewWithoutAnimation()
    }

    func onAddInstructionTapped() {
        let viewController = InstructionSelectionBuilder(
            state: .initial(self)
        ).build()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
