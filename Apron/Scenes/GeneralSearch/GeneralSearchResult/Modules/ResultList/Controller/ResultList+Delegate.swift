//
//  ResultList+Delegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 24.06.2022.
//

import Foundation
import UIKit
import Storages
import Models

extension ResultListViewController: GeneralSearchRecipeCellProtocol {
    func didTapSaveRecipe(with id: Int) {
        saveRecipe(with: id)
    }

    func navigateToRecipe(with id: Int) {
        let vc = RecipePageBuilder(state: .initial(id: id, .community)).build()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func navigateToAuthFromRecipe() {
        handleAuthorizationStatus { }
    }
}
