//
//  MealPlannerRequestBody.swift
//  Models
//
//  Created by Akarys Turganbekuly on 11.02.2023.
//

import Foundation

public struct MealPlannerRequestBody: Codable {
    // MARK: - CodingKeys
    private enum CodingKeys: String, CodingKey {
        case recipeId, date
    }

    // MARK: - Properties

    var recipeId: Int?
    var date: String?

    // MARK: - Init

    public init(
        recipeId: Int?,
        date: String?
    ) {
        self.recipeId = recipeId
        self.date = date
    }

    public func toJSON() -> JSON {
        var params = JSON()
        if let recipeId = recipeId {
            params[CodingKeys.recipeId.rawValue] = recipeId
        }

        if let date = date {
            params[CodingKeys.date.rawValue] = date
        }
        return params
    }
}
