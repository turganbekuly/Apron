//
//  CommunityPage+CreateDelegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 29.05.2022.
//

import UIKit
import APRUIKit
import Models

protocol CommunityPageCreateRecipeProtocol: AnyObject {
    func didCreate()
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
                self.navigationController?.pushViewController(vc, animated: false)
            }
        default:
            break
        }
    }
}

extension CommunityPageViewController: CommunityPageCreateRecipeProtocol {
    func didCreate() {
        recipes.removeAll()
        getRecipesByCommunity(id: id, currentPage: 1)
    }
}
