//
//  IngredientsDescriptionCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 08.02.2022.
//

import Foundation

protocol IIngredientsDescriptionCellViewModel {
    var description: String? { get }
    var cookingTime: String? { get }
}

final class IngredientsDescriptionCellViewModel: IIngredientsDescriptionCellViewModel {
    var description: String?

    var cookingTime: String?

    init(
        description: String?,
        cookingTime: String?
    ) {
        self.description = description
        self.cookingTime = cookingTime
    }
}
