//
//  Main+CookNowDelegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 08.12.2022.
//

import Foundation

extension MainViewController: CookNowCellProtocol {
    func saveRecipeTappedv2(with id: Int) {
        saveRecipe(with: id)
    }

    func navigateToAuthFromRecipev2() {
        handleAuthorizationStatus { }
    }

    func navigateToRecipev2(with id: Int) {
        let viewContoller = RecipePageBuilder(state: .initial(id: id, .main)).build()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewContoller, animated: true)
        }
    }
}
