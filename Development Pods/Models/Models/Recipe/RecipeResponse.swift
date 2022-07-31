//
//  RecipeResponse.swift
//  Models
//
//  Created by Akarys Turganbekuly on 29.04.2022.
//

import Foundation

public struct RecipeResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case id, authorName, createdAt
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
        case isSaved = "added"
        case savedUserCount = "savedByUserCount"
        case likesCount = "likesCount"
        case dislikesCount = "dislikesCount"
        case isHidden = "hidden"
    }

    // MARK: - Properties

    public var id: Int
    public var recipeName: String?
    public var authorName: String?
    public var createdAt: String?
    public var sourceLink: String?
    public var sourceName: String?
    public var imageURL: String?
    public var description: String?
    public var ingredients: [RecipeIngredient]?
    public var instructions: [String]?
    public var servings: Int?
    public var prepTime: Int?
    public var cookTime: Int?
    public var isSaved: Bool?
    public var savedUserCount: Int?
    public var likesCount: Int?
    public var dislikesCount: Int?
    public var isHidden: Bool?

    // MARK: - Init

    public init?(json: JSON) {
        guard let id = json[CodingKeys.id.rawValue] as? Int else {
            return nil
        }
        self.id = id
        self.recipeName = json[CodingKeys.recipeName.rawValue] as? String
        self.authorName = json[CodingKeys.authorName.rawValue] as? String
        self.createdAt = json[CodingKeys.createdAt.rawValue] as? String
        self.sourceLink = json[CodingKeys.sourceLink.rawValue] as? String
        self.sourceName = json[CodingKeys.sourceName.rawValue] as? String
        self.imageURL = json[CodingKeys.imageURL.rawValue] as? String
        self.description = json[CodingKeys.description.rawValue] as? String
        self.ingredients = (json[CodingKeys.ingredients.rawValue] as? [JSON])?.compactMap { RecipeIngredient(json: $0) } ?? []
        self.instructions = json[CodingKeys.instructions.rawValue] as? [String]
        self.servings = json[CodingKeys.servings.rawValue] as? Int
        self.prepTime = json[CodingKeys.prepTime.rawValue] as? Int
        self.cookTime = json[CodingKeys.cookTime.rawValue] as? Int
        self.isSaved = json[CodingKeys.isSaved.rawValue] as? Bool
        self.savedUserCount = json[CodingKeys.savedUserCount.rawValue] as? Int
        self.likesCount = json[CodingKeys.likesCount.rawValue] as? Int
        self.dislikesCount = json[CodingKeys.dislikesCount.rawValue] as? Int
        self.isHidden = json[CodingKeys.isHidden.rawValue] as? Bool
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
        if let prepTime = prepTime {
            params[CodingKeys.prepTime.rawValue] = prepTime
        }
        if let cookTime = cookTime {
            params[CodingKeys.cookTime.rawValue] = cookTime
        }
        return params
    }
}

