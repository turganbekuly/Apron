//
//  CommunityRecipesCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19.01.2022.
//

import Foundation
import Models

protocol CommunityRecipesCellViewModelProtocol: AnyObject {
    var recipe: RecipeResponse? { get }
}

final class CommunityRecipesCellViewModel: CommunityRecipesCellViewModelProtocol {
    // MARK: - Properties

    var recipe: RecipeResponse?

    init(recipe: RecipeResponse?) {
        self.recipe = recipe
    }
}
