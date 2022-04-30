//
//  IngredientsListCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 08.02.2022.
//

import Foundation
import Models

protocol IIngredientsListCellViewModel {
    var serveCount: String { get }
    var ingredients: [RecipeIngredient] { get }
}

final class IngredientsListCellViewModel: IIngredientsListCellViewModel {
    var serveCount: String

    var ingredients: [RecipeIngredient]

    init(
        serveCount: String,
        ingredients: [RecipeIngredient]
    ) {
        self.serveCount = serveCount
        self.ingredients = ingredients
    }
}
