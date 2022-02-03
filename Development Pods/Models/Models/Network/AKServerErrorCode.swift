//
//  AKServerErrorCode.swift
//  Models
//
//  Created by Akarys Turganbekuly on 07.01.2022.
//

import Foundation

public enum AKServerErrorCode: Int {
    case okay = 0
    case badRequest = 1
    case doesntExist = 2
    case otpIncorrect = 3
    case alreadyVerified = 4
    case expired = 5
    case retryCountExceed = 6
    case authentificationError = 7
    case tokenExpired = 8
    case invalidData = 9
    case userExists = 10
    case noCameraAccess = 9997
    case noGalleryAccess = 9998
    case unknown = 9999
    case noInternetConnection = 10006
}
