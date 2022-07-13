//
//  SignUpResponse.swift
//  Models
//
//  Created by Akarys Turganbekuly on 20.05.2022.
//

import Foundation

public struct SignUpResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case managedCommunities
        case communities
        case recipes
        case myRecipes
        case email
        case username
    }

    // MARK: - Properties

    var email: String?
    var username: String?
    var managedCommunities: [CommunityResponse]?
    var communities: [CommunityResponse]?
    var recipes: [RecipeResponse]?
    var myRecipes: [RecipeResponse]?

    public init?(json: JSON) {
        self.email = json[CodingKeys.email.rawValue] as? String
        self.username = json[CodingKeys.username.rawValue] as? String
        self.managedCommunities = (json[CodingKeys.managedCommunities.rawValue] as? [JSON])?
            .compactMap { CommunityResponse(json: $0) } ?? []
        self.communities = (json[CodingKeys.communities.rawValue] as? [JSON])?
            .compactMap { CommunityResponse(json: $0) } ?? []
        self.recipes = (json[CodingKeys.recipes.rawValue] as? [JSON])?
            .compactMap { RecipeResponse(json: $0) } ?? []
        self.myRecipes = (json[CodingKeys.myRecipes.rawValue] as? [JSON])?
            .compactMap { RecipeResponse(json: $0) } ?? []
    }
}
