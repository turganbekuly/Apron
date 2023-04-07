//
//  MessageType.swift
//  AKNetwork
//
//  Created by Akarys Turganbekuly on 13.01.2022.
//

import UIKit

public enum MessageType {
    case loader
    case dialog(String, String, String, String)
    case error(String)
    case success(String)
    case regular(String, String)
    case forceUpdate
    case completeAppleSignin(String, String, String, String)

    public var name: String {
        switch self {
        case .loader:
            return "loader"
        case .dialog:
            return "dialog"
        case .error:
            return "error"
        case .regular:
            return "regular"
        case .success:
            return "success"
        case .forceUpdate:
            return "forceUpdate"
        case .completeAppleSignin:
            return "completeAppleSignin"
        }
    }
}
