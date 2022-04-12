//
//  Auth.swift
//  Models
//
//  Created by Akarys Turganbekuly on 07.01.2022.
//

import Foundation

public struct Auth: Codable {

    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }

    // MARK: - Properties

    public let accessToken: String
    public let refreshToken: String

    // MARK: - Init

    public init?(json: JSON) {
        guard
            let accessToken = json[CodingKeys.accessToken.rawValue] as? String,
            let refreshToken = json[CodingKeys.refreshToken.rawValue] as? String
        else {
            return nil
        }

        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }

}

