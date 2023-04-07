//
//  IngredientAddedModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 23.06.2022.
//

import Foundation

public enum IngredientAddedSourceType: String {
    case recipePage = "recipe_page"
    case selectionFromShoppingList = "shoping_list"
    case selectionFromCreation = "recipe_creation"
}

public struct IngredientAddedModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case name = "ingredient_name"
        case id = "ingredient_id"
        case sourceType = "source_type"
    }

    var id: Int = 0
    var name: String = ""
    var sourceType: String = ""

    public init(
        id: Int,
        name: String,
        sourceType: IngredientAddedSourceType
    ) {
        self.id = id
        self.name = name
        self.sourceType = sourceType.rawValue
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
