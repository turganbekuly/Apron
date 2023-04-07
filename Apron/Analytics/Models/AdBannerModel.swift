//
//  AdBannerModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05.03.2023.
//

import Foundation

public struct AdBannerModel: Codable {
    // MARK: - Properties

    private enum CodingKeys: String, CodingKey {
        case username = "username"
        case imageLink = "image_link"
        case actionLink = "action_link"
    }

    var username: String = ""
    var imageLink: String = ""
    var actionLink: String = ""

    // MARK: - Init

    public init(
        username: String,
        imageLink: String,
        actionLink: String
    ) {
        self.username = username
        self.imageLink = imageLink
        self.actionLink = actionLink
    }

    // MARK: - Methods

    func toJSON() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
              let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        else {
            return [:]
        }
        return json
    }
}
