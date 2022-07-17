//
//  User.swift
//  Models
//
//  Created by Akarys Turganbekuly on 07.01.2022.
//

import Foundation
import Decoders

public struct User: Codable {

    private enum CodingKeys: String, CodingKey {
        case email
        case username
        case myRecipes
        case managedCommunites
    }

    // MARK: - Properties

    public var email: String?
    public var username: String?
    public var myRecipes: [RecipeResponse]?
    public var managedCommunites: [CommunityResponse]?

    // MARK: - Init

    public init?(json: JSON) {
        email = json[CodingKeys.email.rawValue] as? String
        username = json[CodingKeys.username.rawValue] as? String
        myRecipes = (json[CodingKeys.myRecipes.rawValue] as? [JSON])?
            .compactMap { RecipeResponse(json: $0) } ?? []
        managedCommunites = (json[CodingKeys.managedCommunites.rawValue] as? [JSON])?
            .compactMap { CommunityResponse(json: $0) } ?? []
    }
}

