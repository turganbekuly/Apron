//
//  RecipeCreation+AssignValues.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20.04.2022.
//

import Foundation

protocol AssignTypesSelectedDelegate {
    func didSelected(type: AssignTypes)
}

extension RecipeCreationViewController: RecipeCreationAssignCellDelegate {
    func assignButtonTapped(with type: AssignTypes?) {
        guard let type = type else {
            return
        }
        let viewController = AssignBottomSheetBuilder(state: .initial(type, self)).build()
        DispatchQueue.main.async {
            self.navigationController?.presentPanModal(viewController)
        }
    }
}

extension RecipeCreationViewController: AssignTypesSelectedDelegate {
    func didSelected(type: AssignTypes) {
        switch type {
        case .servings(let string):
            recipeCreation?.servings = string
        case .prepTime(let string):
            recipeCreation?.prepTime = string
        case .cookTime(let string):
            recipeCreation?.cookTime = string
        }
        mainView.reloadTableViewWithoutAnimation()
    }
}
