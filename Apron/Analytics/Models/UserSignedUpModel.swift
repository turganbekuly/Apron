//
//  UserSignedUpModel.swift
//  Analytics
//
//  Created by Akarys Turganbekuly on 31.08.2021.
//

import Foundation

public struct UserSignedUpModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case email = "email"
        case name = "user_name"
    }

    var email: String = ""
    var name: String = ""

    public init(
        email: String,
        name: String
    ) {
        self.email = email
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
