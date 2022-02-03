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
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case .initial:
            infoHeaderView.configure(with: RecipeInformationCellViewModel(
                recipeName: "Легкий грибной суп",
                recipeSubtitle: "в Вегетарианские рецепты и еще 2 сообществах",
                recipeSourceURL: "asdgamer1995123"
            ))
            initialState = .ingredients
        }
    }
    
}
