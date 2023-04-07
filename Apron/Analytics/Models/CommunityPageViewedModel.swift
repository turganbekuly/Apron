//
//  CommunityPageViewedModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27.05.2022.
//

import Foundation

enum CommunityPageSourceType: String, Codable {
    case homepage
    case search
    case deeplink
    case unknown
}

struct CommunityPageViewedModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case communityID = "community_id"
        case communityName = "community_name"
        case sourceType = "source_type"
    }

    var communityID: Int = 0
    var communityName: String = ""
    var sourceType: String = ""

    init(
        communityID: Int,
        communityName: String,
        sourceType: CommunityPageSourceType
    ) {
        self.communityID = communityID
        self.communityName = communityName
        self.sourceType = sourceType.rawValue
    }

    func toJSON() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
              let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        else {
            return [:]
        }
        return json
    }
}
