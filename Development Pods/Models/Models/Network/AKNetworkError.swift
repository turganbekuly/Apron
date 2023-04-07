//
//  AKNetworkError.swift
//  Models
//
//  Created by Akarys Turganbekuly on 07.01.2022.
//

import Foundation

public struct AKNetworkError: Error {

    private enum CodingKeys: String, CodingKey {
        case code
        case message
    }

    // MARK: - Properties

    public let code: AKServerErrorCode
    public let message: String?

    // MARK: - Init

    public init?(json: JSON) {
        guard let code = AKServerErrorCode(rawValue: json[CodingKeys.code.rawValue] as? Int ?? 9999) else {
            return nil
        }

        self.code = code
        message = json[CodingKeys.message.rawValue] as? String
    }

    public init(code: AKServerErrorCode, message: String) {
        self.code = code
        self.message = message
    }

}

extension AKNetworkError {

    // MARK: - Static Properties

    public static let serverError = AKNetworkError(code: .badRequest, message: "")
    public static let authorizationError = AKNetworkError(code: .authentificationError, message: "")
    public static let invalidData = AKNetworkError(code: .invalidData, message: "")
    public static let noGalleryAccess = AKNetworkError(code: .noGalleryAccess, message: "")
    public static let noCameraAccess = AKNetworkError(code: .noCameraAccess, message: "")
    public static let noInternetConnection = AKNetworkError(code: .noInternetConnection, message: "")

}
