//
//  SearchEverythingResponse.swift
//  Models
//
//  Created by Akarys Turganbekuly on 30.05.2022.
//

import Foundation

public struct SearchEverythingResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case recipes
        case recipesCount
        case communities
        case communitiesCount
    }

    // MARK: - Properties

    public var recipes: [RecipeResponse]?
    public var recipesCount: Int?
    public var communities: [CommunityResponse]?
    public var communitiesCount: Int?

    // MARK: - Init

    public init?(json: JSON) {
        self.recipesCount = json[CodingKeys.recipesCount.rawValue] as? Int
        self.recipes = (json[CodingKeys.recipes.rawValue] as? [JSON])?
            .compactMap { RecipeResponse(json: $0) } ?? []
        self.communitiesCount = json[CodingKeys.communitiesCount.rawValue] as? Int
        self.communities = (json[CodingKeys.communities.rawValue] as? [JSON])?
            .compactMap { CommunityResponse(json: $0) } ?? []
    }
}
