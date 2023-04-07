//
//  CommunitiesListPageViewedModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27.05.2022.
//

import Foundation

enum CommunitiesListSourceType: String, Codable {
    case homepage
    case search
    case deeplink
    case banner
}

struct CommunitiesListPageViewedModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case categoryName = "category_name"
        case sourceType = "source_type"
    }

    var categoryID: Int = 0
    var categoryName: String = ""
    var sourceType: String

    init(
        categoryID: Int,
        categoryName: String,
        sourceType: CommunitiesListSourceType
    ) {
        self.categoryID = categoryID
        self.categoryName = categoryName
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
