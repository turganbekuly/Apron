//
//  RecipesResponse.swift
//  Models
//
//  Created by Akarys Turganbekuly on 30.05.2022.
//

import Foundation

public struct RecipesResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case recipe
    }

    // MARK: - Properties

    public var recipe: RecipeResponse?

    // MARK: - Init

    public init?(json: JSON) {
        self.recipe = RecipeResponse(json: json[CodingKeys.recipe.rawValue] as? JSON ?? [:])
    }
}
