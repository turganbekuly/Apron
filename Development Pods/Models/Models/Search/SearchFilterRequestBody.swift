//
//  SearchFilterRequestBody.swift
//  Models
//
//  Created by Akarys Turganbekuly on 09.10.2022.
//

import Foundation

public struct SearchFilterRequestBody: Codable {
    private enum CodingKeys: String, CodingKey {
        case query = "name"
        case currentTime
        case time
        case dayTimeType = "whenToCook"
        case cuisines
        case dishTypes = "dishTypes"
        case ingredients = "products"
        case eventTypes = "occasions"
        case lifestyleTypes = "lifestyleTypes"
        case page
        case limit
    }

    public var time: [Int] = []
    public var dayTimeType: [Int] = []
    public var cuisines: [Int] = []
    public var dishTypes: [Int] = []
    public var ingredients: [Int] = []
    public var eventTypes: [Int] = []
    public var lifestyleTypes: [Int] = []
    public var page: Int = 1
    public var limit: Int = 20
    public var currentTime: Int?
    public var query: String = ""

    // MARK: - Init

    public init() {}

    // MARK: - Methods

    public func toJSON() -> JSON {
        var params = JSON()
        if let currentTime = currentTime {
            params[CodingKeys.currentTime.rawValue] = currentTime
        }
        params[CodingKeys.query.rawValue] = query
        params[CodingKeys.limit.rawValue] = limit
        params[CodingKeys.page.rawValue] = page
        params[CodingKeys.lifestyleTypes.rawValue] = lifestyleTypes
        params[CodingKeys.eventTypes.rawValue] = eventTypes
        params[CodingKeys.dishTypes.rawValue] = dishTypes
        params[CodingKeys.dayTimeType.rawValue] = dayTimeType
        params[CodingKeys.cuisines.rawValue] = cuisines
        params[CodingKeys.ingredients.rawValue] = ingredients

        if let time = time.first {
            params[CodingKeys.time.rawValue] = time
        }
        return params
    }
}
