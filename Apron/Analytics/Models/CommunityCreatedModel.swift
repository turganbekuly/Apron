//
//  CommunityCreationPageViewedModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 23.06.2022.
//

import Foundation

public enum CommunityCreationAdditionLevel: String, Codable {
    case `public`
    case `private`
}

public enum CommunityCreationVisibilityLevel: String, Codable {
    case everyone
    case byLink = "by_link"
}

public struct CommunityCreatedModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case categoryName = "category_name"
        case additionLevel = "addition_level"
        case visibilityLevel = "visibility_level"
    }

    var categoryID: Int = 0
    var categoryName: String = ""
    var additionLevel: String = ""
    var visibilityLevel: String = ""

    init(
        categoryID: Int,
        categoryName: String,
        additionLevel: CommunityCreationAdditionLevel,
        visibilityLevel: CommunityCreationVisibilityLevel
    ) {
        self.categoryID = categoryID
        self.categoryName = categoryName
        self.additionLevel = additionLevel.rawValue
        self.visibilityLevel = visibilityLevel.rawValue
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



