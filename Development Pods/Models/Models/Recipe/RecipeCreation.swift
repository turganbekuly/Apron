//
//  RecipeCreation.swift
//  Models
//
//  Created by Akarys Turganbekuly on 11.04.2022.
//

import Foundation

public struct RecipeCreation: Codable {
    private enum CodingKeys: String, CodingKey {
        case recipeName = "name"
        case sourceLink = "link"
        case sourceName = "linkName"
        case imageURL = "image"
        case description = "description"
        case ingredients = "ingredients"
        case instructions = "instructions"
        case servings = "portions"
        case prepTime = "prep_time"
        case cookTime = "cook_time"
    }

    // MARK: - Properties

    public var recipeName: String?
    public var sourceLink: String?
    public var sourceName: String?
    public var imageURL: String?
    public var description: String?
    public var ingredients: [RecipeIngredient]?
    public var instructions: [String]?
    public var servings: Int?
    public var prepTime: String?
    public var cookTime: String?

    // MARK: - Init

    public init() { }

    public init?(from recipe: RecipeResponse) {
        self.recipeName = recipe.recipeName
        self.sourceLink = recipe.sourceLink
        self.sourceName = recipe.sourceName
        self.imageURL = recipe.imageURL
        self.description = recipe.description
        self.ingredients = recipe.ingredients
        self.instructions = recipe.instructions
        self.servings = recipe.servings
        self.prepTime = recipe.prepTime
        self.cookTime = recipe.cookTime
    }

    // MARK: - Methods

    public func toJSON() -> JSON {
        var params = JSON()
        if let name = recipeName {
            params[CodingKeys.recipeName.rawValue] = name
        }
        if let sourceLink = sourceLink {
            params[CodingKeys.sourceLink.rawValue] = sourceLink
        }
        if let sourceName = sourceName {
            params[CodingKeys.sourceName.rawValue] = sourceName
        }
        if let imageURL = imageURL {
            params[CodingKeys.imageURL.rawValue] = imageURL
        }
        if let description = description {
            params[CodingKeys.description.rawValue] = description
        }
        if let ingredients = ingredients {
            params[CodingKeys.ingredients.rawValue] = ingredients.compactMap { $0 }
        }
        if let instructions = instructions {
            params[CodingKeys.instructions.rawValue] = instructions.compactMap { $0 }
        }
        if let servings = servings {
            params[CodingKeys.servings.rawValue] = servings
        }
//        if let prepTime = prepTime {
//            params[CodingKeys.prepTime.rawValue] = prepTime
//        }
//        if let cookTime = cookTime {
//            params[CodingKeys.cookTime.rawValue] = cookTime
//        }
        return params
    }
}
