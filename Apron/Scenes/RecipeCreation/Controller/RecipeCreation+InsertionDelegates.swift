//
//  RecipeCreation+InsertionDelegates.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.04.2022.
//

import UIKit
import Models

protocol IngredientSelectedProtocol: AnyObject {
    func onIngredientSelected(ingredient: RecipeIngredient)
}

protocol InstructionSelectedProtocol: AnyObject {
    func onInstructionSelected(instruction: RecipeInstruction)
}

extension RecipeCreationViewController: IngredientSelectedProtocol {
    func onIngredientSelected(ingredient: RecipeIngredient) {
        ApronAnalytics.shared.sendAmplitudeEvent(
            .ingredientAdded(
                IngredientAddedModel(
                    id: ingredient.product?.id ?? 0,
                    name: ingredient.product?.name ?? ""
                )
            )
        )
        recipeCreation?.ingredients.append(ingredient)
        mainView.reloadTableViewWithoutAnimation()
    }
}

extension RecipeCreationViewController: InstructionSelectedProtocol {
    func onInstructionSelected(instruction: RecipeInstruction) {
        recipeCreation?.instructions.append(instruction)
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
    func onAddInstructionTapped() {
        let viewController = InstructionSelectionBuilder(
            state: .initial((recipeCreation?.instructions.count ?? 0) + 1, self)
        ).build()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
