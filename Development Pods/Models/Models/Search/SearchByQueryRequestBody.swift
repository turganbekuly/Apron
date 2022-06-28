//
//  SearchByQueryRequestBody.swift
//  Models
//
//  Created by Akarys Turganbekuly on 28.06.2022.
//

import Foundation

public struct SearchByQueryRequestBody: Codable {
    private enum CodingKeys: String, CodingKey {
        case currentPage = "page"
        case limit
        case name
    }

    // MARK: - Properties

    public var currentPage: Int
    public var limit: Int
    public var name: String

    // MARK: - Init

    public init(
        currentPage: Int,
        limit: Int,
        name: String
    ) {
        self.currentPage = currentPage
        self.limit = limit
        self.name = name
    }

    // MARK: - Methods

    public func toJSON() -> JSON {
        var params = JSON()
        params[CodingKeys.currentPage.rawValue] = currentPage
        params[CodingKeys.limit.rawValue] = limit
        params[CodingKeys.name.rawValue] = name
        return params
    }
}
