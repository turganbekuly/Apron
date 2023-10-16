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

extension CommunityPageViewController: RecipeSearchCellV2Protocol {
    func saveRecipeTappedv2(with id: Int) {
        saveRecipe(with: id)
    }
    
    func navigateToAuthFromRecipev2() {
        handleAuthorizationStatus { }
    }
    
    func navigateToRecipev2(with id: Int) {
        let vc = RecipePageBuilder(state: .initial(id: id, .community)).build()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
