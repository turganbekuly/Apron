//
//  AuthorizationModel.swift
//  Analytics
//
//  Created by Akarys Turganbekuly on 31.08.2021.
//

import Foundation

public enum AuthorizationModelTypes: String, Codable {
    case signUp
    case signIn
    case skipped
}

public struct AuthorizationModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case email = "email"
        case name = "user_name"
        case sourceType = "source_type"
    }

    var email: String = ""
    var name: String = ""
    var sourceType: String = ""

    public init(
        email: String,
        name: String,
        sourceType: AuthorizationModelTypes
    ) {
        self.email = email
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
