//
//  Auth.swift
//  Models
//
//  Created by Akarys Turganbekuly on 07.01.2022.
//

import Foundation

public enum GrantType: String, Codable {
    case apple = "apple_login"
    case native = "refresh_token"
}

public struct Auth: Codable {

    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case username
        case email
        case grantType
    }

    // MARK: - Properties

    public let accessToken: String
    public let refreshToken: String
    public var username: String?
    public let email: String
    public let grantType: String

    // MARK: - Init

    public init?(json: JSON) {
        guard
            let accessToken = json[CodingKeys.accessToken.rawValue] as? String,
            let refreshToken = json[CodingKeys.refreshToken.rawValue] as? String,
            let email = json[CodingKeys.email.rawValue] as? String
        else {
            return nil
        }

        if let username = json[CodingKeys.username.rawValue] as? String {
            self.username = username
        }

        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.email = email
        self.username = (json[CodingKeys.username.rawValue] as? String) ?? nil
        self.grantType = json[CodingKeys.grantType.rawValue] as? String ?? ""
    }
}
