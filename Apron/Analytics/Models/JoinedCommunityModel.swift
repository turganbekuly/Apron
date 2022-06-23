//
//  JoinedCommunityModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27.05.2022.
//

import Foundation

enum JoinedCommunitySourceType: String, Codable {
    case homepage
    case community
    case search
    case unknown
}

struct JoinedCommunityModel: Codable {
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
        sourceType: JoinedCommunitySourceType
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


