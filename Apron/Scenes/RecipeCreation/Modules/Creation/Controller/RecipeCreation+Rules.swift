//
//  RecipeCreation+Rules.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 23.10.2023.
//

import Foundation

extension RecipeCreationViewController: RecipeCreationRulesCellProtocol {
    func showRules() {
        let vc = WebViewHandler(urlString: AppConstants.recipeCreationRules)
        DispatchQueue.main.async {
            self.presentPanModal(vc)
        }
    }
}
