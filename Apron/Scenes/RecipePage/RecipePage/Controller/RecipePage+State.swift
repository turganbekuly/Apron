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
        case initial
        case displayRecipe(RecipeResponse)
        case displayError(AKNetworkError)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case .initial:
            getRecipe(by: 3)
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
