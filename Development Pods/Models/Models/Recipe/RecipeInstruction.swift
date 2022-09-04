//
//  RecipeInstruction.swift
//  Models
//
//  Created by Akarys Turganbekuly on 20.08.2022.
//

import Foundation

public struct RecipeInstruction: Codable, Equatable {
    // MARK: - Coding keys

    private enum CodingKeys: String, CodingKey {
        case description = "name"
        case image
        case orderNo
    }

    // MARK: - Properties

    public var description: String?
    public var image: String?
    public var orderNo: Int?

    // MARK: - Init

    public init() { }
    
    public init?(json: JSON) {
        self.description = json[CodingKeys.description.rawValue] as? String
        self.image = json[CodingKeys.image.rawValue] as? String
        self.orderNo = json[CodingKeys.orderNo.rawValue] as? Int
    }

    // MARK: - Methods

    public func toJSON() -> JSON {
        var params = JSON()
        if let description = description {
            params[CodingKeys.description.rawValue] = description
        }

        if let image = image {
            params[CodingKeys.image.rawValue] = image
        }

        if let orderNo = orderNo {
            params[CodingKeys.orderNo.rawValue] = orderNo
        }
        return params
    }
}
