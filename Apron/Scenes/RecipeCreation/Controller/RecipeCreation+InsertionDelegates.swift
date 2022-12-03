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
    func onInstructionSelected(instruction: RecipeInstruction, from step: Int?)
}

extension RecipeCreationViewController: IngredientSelectedProtocol {
    func onIngredientSelected(ingredient: RecipeIngredient) {
        ApronAnalytics.shared.sendAnalyticsEvent(
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
    func onInstructionSelected(instruction: RecipeInstruction, from step: Int?) {
        if let step = step {
            recipeCreation?.instructions[step - 1] = instruction
            mainView.reloadTableViewWithoutAnimation()
            return
        }
        recipeCreation?.instructions.append(instruction)
        mainView.reloadTableViewWithoutAnimation()
    }
}

extension RecipeCreationViewController: AddIngredientCellTappedDelegate {
    func onAddIngredientTapped() {
        let viewController = IngredientSelectionBuilder(state: .initial(self, .fullItem)).build()
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
            state: .initial((recipeCreation?.instructions.count ?? 0) + 1, self, nil)
        ).build()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }

    func remove(instruction: RecipeInstruction) {
        recipeCreation?.instructions.removeAll(where: { $0 == instruction })
        mainView.reloadTableViewWithoutAnimation()
    }

    func onInstructionTapped(instruction: RecipeInstruction, step: Int) {
        let viewController = InstructionSelectionBuilder(
            state: .initial(step, self, instruction)
        ).build()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
