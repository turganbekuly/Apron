//
//  SearchRecipesByCommunityIDRequestBody.swift
//  Models
//
//  Created by Akarys Turganbekuly on 28.05.2022.
//

import Foundation

public struct RecipesByCommunityIDRequestBody {
    public let id: Int
    public let limit: Int
    public let currentPage: Int
    public let query: String

    public init(
        id: Int,
        limit: Int,
        currentPage: Int,
        query: String
    ) {
        self.id = id
        self.limit = limit
        self.currentPage = currentPage
        self.query = query
    }
}
