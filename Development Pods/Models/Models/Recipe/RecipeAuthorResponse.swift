//
//  RecipeAuthorResponse.swift
//  Models
//
//  Created by Akarys Turganbekuly on 08.12.2022.
//

import Foundation

public struct RecipeAuthorResponse: Codable {
    // MARK: - Coding Keys

    private enum CodingKeys: String, CodingKey {
        case email, username
    }

    // MARK: - Properties

    public var email: String?
    public var username: String?

    // MARK: - Init

    public init() { }

    public init?(json: JSON) {
        self.email = json[CodingKeys.email.rawValue] as? String
        self.username = json[CodingKeys.username.rawValue] as? String
    }
}
