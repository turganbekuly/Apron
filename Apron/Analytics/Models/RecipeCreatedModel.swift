//
//  RecipeCreatedModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 23.06.2022.
//

import Foundation

public struct RecipeCreatedModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case recipeID = "recipe_id"
        case recipeName = "recipe_name"
        case sourceType = "source_type"
        case imageAdded = "image_added"
        case ingredients = "ingredients"
    }

    var recipeID: Int = 0
    var recipeName: String = ""
    var sourceType: String = ""
    var imageAdded: String = ""
    var ingredients: [String] = []

    init(
        recipeID: Int,
        recipeName: String,
        sourceType: RecipeCreationSourceTypeModel,
        imageAdded: Bool,
        ingredients: [String]
    ) {
        self.recipeID = recipeID
        self.recipeName = recipeName
        self.sourceType = sourceType.rawValue
        self.imageAdded = "\(imageAdded)"
        self.ingredients = ingredients
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




