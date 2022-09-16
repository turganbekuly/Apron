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
            var recipeCreation = RecipeCreation()
            recipeCreation.communityId = community?.id
            let vc = RecipeCreationBuilder(
                state: .initial(
                    .create(
                        recipeCreation, .community(from: self)
                    )
                )
            ).build()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(vc, animated: false)
            }
        case .savedRecipe:
            let vc = AddSavedRecipesBuilder(
                state: .initial(.community(community?.id ?? 0, self))
            ).build()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(vc, animated: false)
            }
        case .shareCommunity:
            let viewController = UIActivityViewController(
                activityItems: [
                    "Зацените сообщество \"\(community?.name ?? "")\" на Apron👀\n https://apron.ws/community/\(community?.id ?? 0)"
                ],
                applicationActivities: nil
            )

            if let popoover = viewController.popoverPresentationController {
                popoover.sourceView = view
                popoover.sourceRect = view.bounds
                popoover.permittedArrowDirections = []
            }

            self.navigationController?.present(viewController, animated: true, completion: nil)
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
