//
//  RecipeSource.swift
//  Models
//
//  Created by Akarys Turganbekuly on 11.04.2022.
//

import Foundation

public struct RecipeSource: Codable {

    private enum CodingKeys: String, CodingKey {
        case name
        case url = "source_link"
    }

    // MARK: - Properties
    public let name: String?
    public let url: String?

    // MARK: - Init
    public init?(json: JSON) {
        self.name = json[CodingKeys.name.rawValue] as? String
        self.url = json[CodingKeys.url.rawValue] as? String
    }

}
