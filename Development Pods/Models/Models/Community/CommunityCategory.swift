//
//  CommunityCategory.swift
//  Models
//
//  Created by Akarys Turganbekuly on 12.05.2022.
//

import Foundation

public struct CommunityCategory: Codable {
    private enum CodingKeys: String, CodingKey {
        case id, name, communities
    }

    // MARK: - Properties

    public var id: Int
    public var name: String?
    public var communities: [CommunityResponse]?

    // MARK: - Init

    public init?(json: JSON) {
        guard let id = json[CodingKeys.id.rawValue] as? Int else {
            return nil
        }
        self.id = id
        self.name = json[CodingKeys.name.rawValue] as? String
        self.communities = (json[CodingKeys.communities.rawValue] as? [JSON])?.compactMap { CommunityResponse(json: $0) } ?? []
    }
}
