//
//  RecipeCommentResponse.swift
//  Models
//
//  Created by Akarys Turganbekuly on 22.07.2022.
//

import Foundation

public struct RecipeCommentResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case description
        case user
        case recipe
        case createdAt
        case tags
        case image
    }

    // MARK: - Properties

    public var id: Int
    public var description: String?
    public var user: String?
    public var recipe: String?
    public var createdAt: String?
    public var tags: [String]?
    public var image: String?

    // MARK: - Init

    public init?(json: JSON) {
        guard let id = json[CodingKeys.id.rawValue] as? Int else {
            return nil
        }
        self.id = id

        self.description = json[CodingKeys.description.rawValue] as? String
        self.user = json[CodingKeys.user.rawValue] as? String
        self.recipe = json[CodingKeys.recipe.rawValue] as? String
        self.createdAt = json[CodingKeys.createdAt.rawValue] as? String
        self.tags = json[CodingKeys.tags.rawValue] as? [String]
        self.image = json[CodingKeys.image.rawValue] as? String
    }
}
