//
//  CommunityPage+CellDelegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 29.05.2022.
//

import Foundation
import UIKit
import Storages
import Models

extension CommunityPageViewController: CommunityRecipeCellProtocol {
    func didTapSaveRecipe(with id: Int) {
        saveRecipe(with: id)
    }

    func navigateToRecipe(with id: Int) {
        let vc = RecipePageBuilder(state: .initial(id: id)).build()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func navigateToAuthFromRecipe() {
        handleAuthorizationStatus { }
    }

}
