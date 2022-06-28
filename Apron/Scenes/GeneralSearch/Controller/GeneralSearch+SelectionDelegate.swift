//
//  GeneralSearch+SelectionDelegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 26.06.2022.
//

import Foundation
import Models

extension GeneralSearchViewController: ResultListViewControllerDelegate {
    func controller(_ contoller: UIViewController, didSelect recipe: RecipeResponse) {
        let vc = RecipePageBuilder(state: .initial(id: recipe.id, .search)).build()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func controller(_ controller: UIViewController, didSelect community: CommunityResponse) {
        let vc = CommunityPageBuilder(state: .initial(.fromSearch(id: community.id))).build()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
