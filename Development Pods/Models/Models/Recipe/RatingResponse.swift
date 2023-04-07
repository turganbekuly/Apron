//
//  RatingResponse.swift
//  Models
//
//  Created by Akarys Turganbekuly on 09.06.2022.
//

import Foundation

public struct RatingResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case likesCount
        case dislikesCount
    }

    // MARK: - Params

    var likesCount: Int?
    var dislikesCount: Int?

    // MARK: - Init

    public init?(json: JSON) {
        self.likesCount = json[CodingKeys.likesCount.rawValue] as? Int
        self.dislikesCount = json[CodingKeys.dislikesCount.rawValue] as? Int
    }
}
