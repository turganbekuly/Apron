//
//  RecipePage+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

extension RecipePageViewController {
    
    // MARK: - State
    public enum State {
        case initial(id: Int)
        case displayRecipe(RecipeResponse)
        case displayError(AKNetworkError)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(id):
            getRecipe(by: id)
            showLoader()
        case let .displayRecipe(recipe):
            hideLoader()
            self.recipe = recipe
        case let .displayError(error):
            hideLoader()
            print(error)
        }
    }
    
}
