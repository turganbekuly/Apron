//
//  GeneralSearchRecipeViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.05.2022.
//

import Models

protocol GeneralSearchRecipeViewModelProtocol {
    var recipe: RecipeResponse? { get }
}

struct GeneralSearchRecipeViewModel: GeneralSearchRecipeViewModelProtocol {
    var recipe: RecipeResponse?
}

