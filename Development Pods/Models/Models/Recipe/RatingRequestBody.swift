//
//  RatingRequestBody.swift
//  Models
//
//  Created by Akarys Turganbekuly on 09.06.2022.
//

import Foundation

public struct RatingRequestBody: Codable {
    private enum CodingKeys: String, CodingKey {
        case recipeID = "recipeId"
        case isLiked = "positive"
    }

    // MARK: - Properties

    var recipeID: Int
    var isLiked: Bool

    // MARK: - Init

    public init(
        recipeID: Int,
        isLiked: Bool
    ) {
        self.recipeID = recipeID
        self.isLiked = isLiked

    }

    // MARK: - Methods

    public func toJSON() -> JSON {
        var params = JSON()
        params[CodingKeys.recipeID.rawValue] = recipeID
        params[CodingKeys.isLiked.rawValue] = isLiked
        return params
    }
}
