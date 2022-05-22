//
//  IngredientsListCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 08.02.2022.
//

import Foundation
import Models

protocol IIngredientsListCellViewModel {
    var serveCount: Int { get }
    var ingredients: [RecipeIngredient] { get }
}

final class IngredientsListCellViewModel: IIngredientsListCellViewModel {
    var serveCount: Int

    var ingredients: [RecipeIngredient]

    init(
        serveCount: Int,
        ingredients: [RecipeIngredient]
    ) {
        self.serveCount = serveCount
        self.ingredients = ingredients
    }
}
