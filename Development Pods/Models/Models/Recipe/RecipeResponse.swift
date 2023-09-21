//
//  RecipeResponse.swift
//  Models
//
//  Created by Akarys Turganbekuly on 29.04.2022.
//

import Foundation

public enum RecipeStatusType: String, Codable, Comparable {
    case active = "Active"
    case pending = "Pending"
    case declined = "Rework"

    public var title: String? {
        switch self {
        case .active:
            return "Опубликовано"
        case .pending:
            return "На проверке"
        case .declined:
            return "Отклонено"
        }
    }

    private var sortOrder: Int {
        switch self {
        case .declined:
            return 0
        case .pending:
            return 1
        case .active:
            return 2
        }
    }

    public static func <(lhs: RecipeStatusType, rhs: RecipeStatusType) -> Bool {
        return lhs.sortOrder < rhs.sortOrder
    }
}

public struct RecipeResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case id, createdAt
        case authorName = "author"
        case recipeName = "name"
        case sourceLink = "link"
        case sourceName = "linkName"
        case imageURL = "image"
        case description = "description"
        case ingredients = "ingredients"
        case instructions = "instructions"
        case servings = "portions"
        case cookTime = "cookTime"
        case isSaved = "added"
        case savedUserCount = "savedByUserCount"
        case likesCount = "likesCount"
        case dislikesCount = "dislikesCount"
        case isHidden = "hidden"
        case status
        case reworkInfo
        case promo = "promoCode"
        case whenToCook = "whenToCook"
        case dishType
        case occasion
        case lifestyleType
        case sort
    }

    // MARK: - Properties

    public var id: Int
    public var recipeName: String?
    public var authorName: RecipeAuthorResponse?
    public var createdAt: String?
    public var sourceLink: String?
    public var sourceName: String?
    public var imageURL: String?
    public var description: String?
    public var ingredients: [RecipeIngredient]?
    public var instructions: [RecipeInstruction]?
    public var servings: Int?
    public var cookTime: Int?
    public var isSaved: Bool?
    public var savedUserCount: Int?
    public var likesCount: Int?
    public var dislikesCount: Int?
    public var isHidden: Bool?
    public var status: RecipeStatusType?
    public var reworkInfo: [String]?
    public var promo: String?
    public var whenToCook: [Int]?
    public var dishType: [Int]?
    public var occasion: [Int]?
    public var lifestyleType: [Int]?
    public var sort: Double?

    // MARK: - Init

    public init?(json: JSON) {
        guard let id = json[CodingKeys.id.rawValue] as? Int else {
            return nil
        }
        self.id = id
        self.recipeName = json[CodingKeys.recipeName.rawValue] as? String
        self.authorName = RecipeAuthorResponse(json: json[CodingKeys.authorName.rawValue] as? JSON ?? [:])
        self.createdAt = json[CodingKeys.createdAt.rawValue] as? String
        self.sourceLink = json[CodingKeys.sourceLink.rawValue] as? String
        self.sourceName = json[CodingKeys.sourceName.rawValue] as? String
        self.imageURL = json[CodingKeys.imageURL.rawValue] as? String
        self.description = json[CodingKeys.description.rawValue] as? String
        self.ingredients = (json[CodingKeys.ingredients.rawValue] as? [JSON])?.compactMap { RecipeIngredient(json: $0) } ?? []
        self.instructions = (json[CodingKeys.instructions.rawValue] as? [JSON])?.compactMap { RecipeInstruction(json: $0) } ?? []
        self.servings = json[CodingKeys.servings.rawValue] as? Int
        self.cookTime = json[CodingKeys.cookTime.rawValue] as? Int
        self.isSaved = json[CodingKeys.isSaved.rawValue] as? Bool
        self.savedUserCount = json[CodingKeys.savedUserCount.rawValue] as? Int
        self.likesCount = json[CodingKeys.likesCount.rawValue] as? Int
        self.dislikesCount = json[CodingKeys.dislikesCount.rawValue] as? Int
        self.isHidden = json[CodingKeys.isHidden.rawValue] as? Bool
        self.status = RecipeStatusType(rawValue: json[CodingKeys.status.rawValue] as? String ?? "Active")
        self.reworkInfo = json[CodingKeys.reworkInfo.rawValue] as? [String]
        self.promo = json[CodingKeys.promo.rawValue] as? String
        self.whenToCook = json[CodingKeys.whenToCook.rawValue] as? [Int]
        self.dishType = json[CodingKeys.dishType.rawValue] as? [Int]
        self.occasion = json[CodingKeys.occasion.rawValue] as? [Int]
        self.lifestyleType = json[CodingKeys.lifestyleType.rawValue] as? [Int]
        self.sort = json[CodingKeys.sort.rawValue] as? Double
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
        if let cookTime = cookTime {
            params[CodingKeys.cookTime.rawValue] = cookTime
        }
        return params
    }
}
