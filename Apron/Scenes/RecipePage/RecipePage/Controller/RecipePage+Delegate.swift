//
//  RecipePage+Delegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 24.05.2022.
//

import Foundation

extension RecipePageViewController: BottomStickyViewDelegate {
    func addButtonTapped() {
        let vc = CreateActionFlowBuilder(state: .initial(.addToFromRecipe, self)).build()
        DispatchQueue.main.async {
            self.navigationController?.presentPanModal(vc)
        }
    }

    func saveButtonTapped() {
        //
    }
}

extension RecipePageViewController: CreateActionFlowProtocol {
    func handleChosenAction(type: CreateActionType) {
        switch type {
        case .shoppingList:
            print("asd")
        default:
            break
        }
    }
}
