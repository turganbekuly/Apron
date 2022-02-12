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
    var ingredients: [IngredientInfo] { get }
}

final class IngredientsListCellViewModel: IIngredientsListCellViewModel {
    var serveCount: Int

    var ingredients: [IngredientInfo]

    init(
        serveCount: Int,
        ingredients: [IngredientInfo]
    ) {
        self.serveCount = serveCount
        self.ingredients = ingredients
    }
}
