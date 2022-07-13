//
//  SignUpRequest.swift
//  Models
//
//  Created by Akarys Turganbekuly on 20.05.2022.
//

import Foundation

public struct SignUpRequest: Codable {
    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
        case username, password, email
    }

    // MARK: - Properties

    let username: String
    let email: String
    let password: String

    // MARK: - Init

    public init(
        username: String,
        email: String,
        password: String
    ) {
        self.username = username
        self.email = email
        self.password = password
    }

    // MARK: - Public method

    public func toJSON() -> JSON {
        var params = JSON()
        params[CodingKeys.username.rawValue] = username
        params[CodingKeys.email.rawValue] = email
        params[CodingKeys.password.rawValue] = password
        return params
    }
}
