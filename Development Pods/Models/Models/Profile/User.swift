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
        case id
        case email
        case username
        case myRecipes
        case managedCommunites
        case image
        case bonusAmount
    }

    // MARK: - Properties

    public var id: Int?
    public var email: String?
    public var username: String?
    public var myRecipes: [RecipeResponse]?
    public var managedCommunites: [CommunityResponse]?
    public var image: String?
    public var bonusAmount: Int?

    // MARK: - Init

    public init() { }

    public init?(json: JSON) {
        guard let id = json[CodingKeys.id.rawValue] as? Int else {
            return nil
        }
        self.id = id
        email = json[CodingKeys.email.rawValue] as? String
        username = json[CodingKeys.username.rawValue] as? String
        image = json[CodingKeys.image.rawValue] as? String
        bonusAmount = json[CodingKeys.bonusAmount.rawValue] as? Int
        myRecipes = (json[CodingKeys.myRecipes.rawValue] as? [JSON])?
            .compactMap { RecipeResponse(json: $0) } ?? []
        managedCommunites = (json[CodingKeys.managedCommunites.rawValue] as? [JSON])?
            .compactMap { CommunityResponse(json: $0) } ?? []
    }

    public func toJSON() -> JSON {
        var params = JSON()
        if let email = email {
            params[CodingKeys.email.rawValue] = email
        }

        if let username = username {
            params[CodingKeys.username.rawValue] = username
        }
        
        if let image = image {
            params[CodingKeys.image.rawValue] = image
        }

        return params
    }
}
