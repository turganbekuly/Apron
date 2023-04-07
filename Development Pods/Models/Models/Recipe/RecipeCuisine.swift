//
//  RecipeCuisine.swift
//  Models
//
//  Created by Akarys Turganbekuly on 09.10.2022.
//

import Foundation

public struct RecipeCuisine: Codable, Equatable {
    private enum CodingKeys: String, CodingKey {
        case name, id
    }

    public var id: Int
    public var name: String?

    // MARK: - Init

    public init?(json: JSON) {
        guard let id = json[CodingKeys.id.rawValue] as? Int else {
            return nil
        }
        self.id = id
        self.name = json[CodingKeys.name.rawValue] as? String
    }

    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

    // MARK: - Methods

    public static func ==(lhs: RecipeCuisine, rhs: RecipeCuisine) -> Bool {
        return lhs.id == rhs.id
    }
}
