//
//  RecipeSearchInitialState.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 12.12.2022.
//

import Foundation
import Models

enum RecipeSearchInitialState {
    case generalSearch(SearchFilterRequestBody)
    case savedRecipesSearch
}
