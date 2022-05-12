//
//  CommunityCreation.swift
//  Models
//
//  Created by Akarys Turganbekuly on 12.05.2022.
//

import Foundation

public struct CommunityCreation: Codable {
    private enum CodingKeys: String, CodingKey {
        case communityName = "name"
        case imageURL = "image"
        case description
        case communityCategoryId
        case privateAdding
        case category
    }

    public var communityName: String?
    public var imageURL: String?
    public var description: String?
    public var communityCategoryId: Int?
    public var privateAdding: Bool?
    public var category: CommunityCategory? {
        didSet {
            communityCategoryId = category?.id
        }
    }

    public init() { }

    public init?(from community: CommunityResponse) {
        self.communityName = community.name
        self.imageURL = community.image
        self.description = community.description
        // Add full category model, private adding, visiable flag
        self.communityCategoryId = 0
        self.privateAdding = false
        self.category = nil
    }

    // MARK: - Methods

    public func toJSON() -> JSON {
        var params = JSON()
        if let communityName = communityName {
            params[CodingKeys.communityName.rawValue] = communityName
        }
        if let imageURL = imageURL {
            params[CodingKeys.imageURL.rawValue] = imageURL
        }
        if let description = description {
            params[CodingKeys.description.rawValue] = description
        }
        if let communityCategoryId = communityCategoryId {
            params[CodingKeys.communityCategoryId.rawValue] = communityCategoryId
        }
        if let privateAdding = privateAdding {
            params[CodingKeys.privateAdding.rawValue] = privateAdding
        }
        return params
    }
}
