//
//  SearchMadeModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 23.06.2022.
//

import Foundation

enum SearchMadeSourceType: String, Codable {
    case communityPage = "community_page"
    case searchTab = "search_tab"
    case savedTab = "saved_tab"
    case searchByIngredients = "search_by_ingredients"
}

struct SearchMadeModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case searchTerm = "search_term"
        case sourceType = "source_type"
        case selectedItemTab = "selected_item_tab"
        case selectedItemName = "selected_item_name"
    }

    var searchTerm: String = ""
    var sourceType: String = ""
    var selectedItemTab: String = ""
    var selectedItemName: String = ""

    init(
        searchTerm: String,
        sourceType: SearchMadeSourceType,
        selectedItemTab: String,
        selectedItemName: String
    ) {
        self.searchTerm = searchTerm
        self.sourceType = sourceType.rawValue
        self.selectedItemTab = selectedItemTab
        self.selectedItemName = selectedItemName
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
