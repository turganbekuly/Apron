//
//  SearchFilterRequestBody.swift
//  Models
//
//  Created by Akarys Turganbekuly on 09.10.2022.
//

import Foundation

public struct SearchFilterRequestBody: Codable {
    private enum CodingKeys: String, CodingKey {
        case cookingTime = "when_to_cook"
        case cuisines
        case dishTypes = "dish"
        case ingredients
        case eventTypes = "event"
        case lifestyleTypes = "lifestyle"
    }

    public var cookingTime: [SuggestedCookingTime]
    public var cuisines: [RecipeCuisine]
    public var dishTypes: [SuggestedDishType]
    public var ingredients: [RecipeIngredient]
    public var eventTypes: [SuggestedEventType]
    public var lifestyleTypes: [SuggestedLifestyleType]

    // MARK: - Init

    public init(
        cookingTime: [SuggestedCookingTime],
        cuisines: [RecipeCuisine],
        dishTypes: [SuggestedDishType],
        ingredients: [RecipeIngredient],
        eventTypes: [SuggestedEventType],
        lifestyleTypes: [SuggestedLifestyleType]
    ) {
        self.cookingTime = cookingTime
        self.cuisines = cuisines
        self.dishTypes = dishTypes
        self.ingredients = ingredients
        self.eventTypes = eventTypes
        self.lifestyleTypes = lifestyleTypes
    }

    // MARK: - Methods

    public func toJSON() -> JSON {
        var params = JSON()
        return params
    }
}
