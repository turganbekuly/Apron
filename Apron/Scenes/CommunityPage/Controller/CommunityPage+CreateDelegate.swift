//
//  CommunityPage+CreateDelegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 29.05.2022.
//

import UIKit
import DesignSystem
import Models

protocol CommunityPageCreateRecipeProtocol: AnyObject {
    func didCreate(recipe: RecipeResponse)
}

extension CommunityPageViewController: CreateActionFlowProtocol {
    func handleChosenAction(type: CreateActionType) {
        switch type {
        case .newRecipe:
            let vc = RecipeCreationBuilder(
                state: .initial(
                    .create(
                        RecipeCreation(), .community(id: community?.id ?? 1, from: self)
                    )
                )
            ).build()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        default:
            break
        }
    }
}

extension CommunityPageViewController: CommunityPageCreateRecipeProtocol {
    func didCreate(recipe: RecipeResponse) {
        guard let section = sections.firstIndex(where: { $0.section == .topView }) else { return }
        self.recipes.insert(recipe, at: 0)
        sections[section].rows = self.recipes.compactMap { .recipiesView($0) }
        mainView.reloadData()
    }
}
