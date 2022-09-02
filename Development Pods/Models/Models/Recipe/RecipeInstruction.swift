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
    }

    // MARK: - Properties

    public var description: String?
    public var image: String?

    // MARK: - Init

    public init() { }
    
    public init?(json: JSON) {
        self.description = json[CodingKeys.description.rawValue] as? String
        self.image = json[CodingKeys.image.rawValue] as? String
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
        return params
    }
}
