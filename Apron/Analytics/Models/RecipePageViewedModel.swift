//
//  RecipePageViewedModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 23.06.2022.
//

import Foundation

struct RecipePageViewedModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case recipeID = "recipe_id"
        case recipeName = "recipe_name"
        case sourceType = "source_type"
        case isSaved = "is_saved"
    }

    var recipeID: Int = 0
    var recipeName: String = ""
    var sourceType: String = ""
    var isSaved: String = ""

    init(
        recipeID: Int,
        recipeName: String,
        sourceType: RecipeCreationSourceTypeModel,
        isSaved: Bool
    ) {
        self.recipeID = recipeID
        self.recipeName = recipeName
        self.sourceType = sourceType.rawValue
        self.isSaved = "\(isSaved)"
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
