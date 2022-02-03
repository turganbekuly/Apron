//
//  User.swift
//  Models
//
//  Created by Akarys Turganbekuly on 07.01.2022.
//

import Foundation
import Decoders

public struct User: Codable {

    private enum CodingKeys: String, CodingKey {
        case id, email
        case birthDate = "birth_date"
        case firstName = "first_name"
        case lastName = "last_name"
    }

    // MARK: - Properties

    public let id: Int
    public var email: String?
    public var birthDate: Date?
    public var firstName: String?
    public var lastName: String?

    // MARK: - Init

    public init?(json: AKJSON) {
        guard let id = json[CodingKeys.id.rawValue] as? Int else {
            return nil
        }

        self.id = id
        email = json[CodingKeys.email.rawValue] as? String
        birthDate = DateDecoder.decodeISODate(from: json[CodingKeys.birthDate.rawValue] as? String)
        firstName = json[CodingKeys.firstName.rawValue] as? String
        lastName = json[CodingKeys.lastName.rawValue] as? String
    }

    // MARK: - Methods

    public func toJSON() -> AKJSON {
        var params = AKJSON()
        params[CodingKeys.firstName.rawValue] = firstName ?? ""
        params[CodingKeys.lastName.rawValue] = lastName ?? ""
        params[CodingKeys.email.rawValue] = email ?? ""
        if
            let birthDate = birthDate,
            let birthDateString = DateDecoder.decodeString(from: birthDate)
        {
            params[CodingKeys.birthDate.rawValue] = birthDateString
        }
        return params
    }

}

