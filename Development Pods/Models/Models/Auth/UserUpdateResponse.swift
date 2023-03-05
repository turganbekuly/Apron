//
//  UserUpdateResponse.swift
//  Models
//
//  Created by Akarys Turganbekuly on 27.02.2023.
//

import Foundation

public enum OperationResultType: String, Codable {
    case success = "SUCCESS"
    case error = "ERROR"
}

public struct UserUpdateResponse: Codable {
    // MARK: - Properties
    
    private enum CodingKeys: String, CodingKey {
        case operationResult, operationName, message
    }

    public var operationResult: OperationResultType?
    public var operationName: String?
    public var message: String?

    // MARK: - Methods

    public init?(json: JSON) {
        self.operationResult = OperationResultType(rawValue: json[CodingKeys.operationResult.rawValue] as? String ?? "ERROR")
        self.operationName = json[CodingKeys.operationName.rawValue] as? String
        self.message = json[CodingKeys.message.rawValue] as? String
    }
}
