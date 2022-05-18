//
//  CommunityResponse.swift
//  Models
//
//  Created by Akarys Turganbekuly on 01.05.2022.
//

import Foundation

public struct CommunityResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case description
        case communityCategoryName
        case privateAdding
        case youtubeLink
        case instagramLink
        case tiktokLink
        case webLink
        case recipes
        case joined
        case users
        case recipesCount
        case usersCount
    }

    // MARK: - Properties

    public var id: Int
    public var name: String?
    public var image: String?
    public var description: String?
    public var communityCategoryName: String?
    public var privateAdding: Bool?
    public var youtubeLink: String?
    public var instagramLink: String?
    public var tiktokLink: String?
    public var webLink: String?
    public var recipes: [RecipeResponse]?
    public var users: [Int]?
    public var joined: Bool?
    public var recipesCount: Int?
    public var usersCount: Int?

    // MARK: - Init

    public init?(json: JSON) {
        // Add full category model, private adding, visiable flag
        guard let id = json[CodingKeys.id.rawValue] as? Int else {
            return nil
        }
        self.id = id
        self.name = json[CodingKeys.name.rawValue] as? String
        self.image = json[CodingKeys.image.rawValue] as? String
        self.description = json[CodingKeys.description.rawValue] as? String
        self.communityCategoryName = json[CodingKeys.communityCategoryName.rawValue] as? String
        self.privateAdding = json[CodingKeys.privateAdding.rawValue] as? Bool
        self.youtubeLink = json[CodingKeys.youtubeLink.rawValue] as? String
        self.instagramLink = json[CodingKeys.instagramLink.rawValue] as? String
        self.tiktokLink = json[CodingKeys.tiktokLink.rawValue] as? String
        self.webLink = json[CodingKeys.webLink.rawValue] as? String
        self.recipes = (json[CodingKeys.recipes.rawValue] as? [JSON])?.compactMap { RecipeResponse(json: $0 ) } ?? []
        self.users = json[CodingKeys.users.rawValue] as? [Int]
        self.joined = json[CodingKeys.communityCategoryName.rawValue] as? Bool
        self.recipesCount = json[CodingKeys.recipesCount.rawValue] as? Int
        self.usersCount = json[CodingKeys.usersCount.rawValue] as? Int
    }
}
