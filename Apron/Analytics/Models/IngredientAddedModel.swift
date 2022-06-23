//
//  IngredientAddedModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 23.06.2022.
//

import Foundation

public struct IngredientAddedModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case name = "ingredient_name"
        case id = "ingredient_id"
    }

    var id: Int = 0
    var name: String = ""

    public init(
        id: Int,
        name: String
    ) {
        self.id = id
        self.name = name
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

