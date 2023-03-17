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
        case cookTime = "cookTime"
        case communityId = "communityId"
        case isHidden = "hidden"
        case whenToCook = "whenToCook"
        case dishType
        case occasion
        case lifestyleType
        case cuisineId
        case email = "authorEmail"
        case promo = "promoCode"
        case id
    }

    // MARK: - Properties

    public var id: Int?
    public var recipeName: String?
    public var sourceLink: String?
    public var sourceName: String?
    public var imageURL: String?
    public var description: String?
    public var ingredients = [RecipeIngredient]()
    public var instructions = [RecipeInstruction]()
    public var servings: Int?
    public var cookTime: Int?
    public var communityId: Int?
    public var isHidden: Bool?
    public var whenToCook: [Int]?
    public var dishType: [Int]?
    public var occasion: [Int]?
    public var lifestyleType: [Int]?
    public var cuisineId: Int?
    public var email: String?
    public var promo: String?

    // MARK: - Init

    public init() { }

    public init?(from recipe: RecipeResponse) {
        self.id = recipe.id
        self.recipeName = recipe.recipeName
        self.sourceLink = recipe.sourceLink
        self.sourceName = recipe.sourceName
        self.imageURL = recipe.imageURL
        self.description = recipe.description
        self.ingredients = recipe.ingredients ?? []
        self.instructions = recipe.instructions ?? []
        self.servings = recipe.servings
        self.cookTime = recipe.cookTime
        self.isHidden = recipe.isHidden
        self.cuisineId = nil
        self.communityId = nil
        self.whenToCook = recipe.whenToCook
        self.dishType = recipe.dishType
        self.occasion = recipe.occasion
        self.lifestyleType = recipe.lifestyleType
        self.email = nil
        self.promo = recipe.promo
    }

    // MARK: - Methods

    public func toJSON() -> JSON {
        var params = JSON()
        if let id = id {
            params[CodingKeys.id.rawValue] = id
        }
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

        params[CodingKeys.ingredients.rawValue] = ingredients.compactMap { $0.toJSON() }

        params[CodingKeys.instructions.rawValue] = instructions.compactMap { $0.toJSON() }

        if let servings = servings {
            params[CodingKeys.servings.rawValue] = servings
        }
        if let cookTime = cookTime {
            params[CodingKeys.cookTime.rawValue] = cookTime
        }
        if let communityId = communityId {
            params[CodingKeys.communityId.rawValue] = communityId
        }
        if let isHidden = isHidden {
            params[CodingKeys.isHidden.rawValue] = isHidden
        }

        if let cuisineId = cuisineId {
            params[CodingKeys.cuisineId.rawValue] = cuisineId
        }

        params[CodingKeys.whenToCook.rawValue] = whenToCook

        params[CodingKeys.dishType.rawValue] = dishType

        params[CodingKeys.occasion.rawValue] = occasion

        params[CodingKeys.lifestyleType.rawValue] = lifestyleType

        if let email = email {
            params[CodingKeys.email.rawValue] = email
        }

        if let promo = promo {
            params[CodingKeys.promo.rawValue] = promo
        }
        return params
    }
}
