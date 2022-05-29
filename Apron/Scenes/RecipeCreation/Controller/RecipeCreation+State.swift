//
//  RecipeCreation+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

extension RecipeCreationViewController {
    
    // MARK: - State
    public enum State {
        case initial(RecipeCreationInitialState)
        case recipeCreationSucceed(RecipeResponse)
        case recipeCreationFailed(AKNetworkError)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(state):
            self.initialState = state
        case let .recipeCreationSucceed(recipe):
            show(type: .success("Рецепт создался успешно"), firstAction: nil, secondAction: nil)
            delegate?.didCreate(recipe: recipe)
            self.navigationController?.popViewController(animated: true)
        case .recipeCreationFailed:
            show(type: .error("Произошла ошибка при создании"), firstAction: nil, secondAction: nil)
        }
    }
    
}
