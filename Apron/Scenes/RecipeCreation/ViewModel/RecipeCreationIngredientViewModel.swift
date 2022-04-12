//
//  RecipeCreationIngredientViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.04.2022.
//

import Foundation

protocol RecipeCreationIngredientViewModelProtocol {
    var name: String { get }
    var amount: Double { get }
    var measurment: String { get }
}

struct RecipeCreationIngredientViewModel: RecipeCreationIngredientViewModelProtocol {
    let name: String
    let amount: Double
    let measurment: String
}
