//
//  SavedRecipesInitialState.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15.01.2023.
//

import Foundation
import Models

protocol SavedRecipeOutputModule: AnyObject {
    func savedRecipeSelected(recipe: RecipeResponse)
}

enum SavedRecipesInitialState {
    case tab
    case mealPlanner(SavedRecipeOutputModule)
}
