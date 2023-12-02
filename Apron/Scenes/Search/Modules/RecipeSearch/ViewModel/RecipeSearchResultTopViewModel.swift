//
//  RecipeSearchResultTopViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 08.10.2022.
//

import Foundation

protocol RecipeSearchResultTopViewModelProtocol {
    var recipeImage: String? { get }
    var cookTime: String? { get }
}

struct RecipeSearchResultTopViewModel: RecipeSearchResultTopViewModelProtocol {
    var recipeImage: String?
    var cookTime: String?
}
