//
//  AuthStorage.swift
//  AKNetwork
//
//  Created by Akarys Turganbekuly on 07.01.2022.
//

import KeychainAccess
import Models

public enum AuthorizationStatus: String {
    case authorized = "true"
    case unauthorized = "false"
}

public protocol AuthStorageProtocol {
    var accessToken: String? { get set }
    var username: String? { get set }
    var email: String? { get set }
    var refreshToken: String? { get set }
    var deviceToken: String? { get set }
    var isUserAuthorized: Bool { get set }
    var grantType: String? { get set }
    var launchAuthorizationScreenShown: Bool { get set }
    func save(model: Auth)
    func clear()
    func canAuthentificate() -> Bool
}

public final class AuthStorage: AuthStorageProtocol {

    private enum Constants {
        static let accessToken = "accessToken"
        static let username = "username"
        static let email = "email"
        static let refreshToken = "refreshToken"
        static let deviceToken = "deviceToken"
        static let isUserAuthorized = "isUserAuthorized"
        static let grantType = "grant_type"
        static let launchAuthorizationScreenShown = "launchAuthorizationScreenShown"
    }

    // MARK: - Properties

    public static var shared: AuthStorageProtocol = AuthStorage()
    private let keychain: Keychain

    public var accessToken: String? {
        get { try? keychain.get(Constants.accessToken) }
        set { updateAccessToken(newValue) }
    }

    public var refreshToken: String? {
        get { try? keychain.get(Constants.refreshToken) }
        set { updateRefreshToken(newValue) }
    }

    public var username: String? {
        get { try? keychain.get(Constants.username) }
        set { updateUsername(newValue) }
    }

    public var email: String? {
        get { try? keychain.get(Constants.email) }
        set { updateEmail(newValue) }
    }

    public var deviceToken: String? {
        get { try? keychain.get(Constants.deviceToken) }
        set { updateDeviceToken(newValue) }
    }

    public var isUserAuthorized: Bool {
        get { AuthStorage.isUserAuthorized }
        set { AuthStorage.isUserAuthorized = newValue }
    }

    public var grantType: String? {
        get { try? keychain.get(Constants.grantType) }
        set { updateGrantType(grantType: newValue) }
    }

    public var launchAuthorizationScreenShown: Bool {
        get { AuthStorage.launchAuthorizationScreenShown }
        set { AuthStorage.launchAuthorizationScreenShown = newValue }
    }

    // MARK: - Init

    public init() {
        keychain = Keychain()
    }

    // MARK: - Methods

    public func save(model: Auth) {
        accessToken = model.accessToken
        refreshToken = model.refreshToken
        username = model.username
        email = model.email
        grantType = model.grantType
        isUserAuthorized = true
    }

    public func clear() {
        accessToken = nil
        refreshToken = nil
        username = nil
        email = nil
        isUserAuthorized = false
        CartManager.shared.resetCart()
        UserStorage().clear()
    }

    private func updateAccessToken(_ refreshToken: String?) {
        if let refreshToken = refreshToken {
            try? keychain.set(refreshToken, key: Constants.accessToken)
        } else {
            try? keychain.remove(Constants.accessToken)
        }
    }

    private func updateRefreshToken(_ refreshToken: String?) {
        if let refreshToken = refreshToken {
            try? keychain.set(refreshToken, key: Constants.refreshToken)
        } else {
            try? keychain.remove(Constants.refreshToken)
        }
    }

    private func updateUsername(_ username: String?) {
        if let username = username {
            try? keychain.set(username, key: Constants.username)
        } else {
            try? keychain.remove(Constants.username)
        }
    }

    private func updateEmail(_ email: String?) {
        if let email = email {
            try? keychain.set(email, key: Constants.email)
        } else {
            try? keychain.remove(Constants.email)
        }
    }

    private func updateDeviceToken(_ deviceToken: String?) {
        if let deviceToken = deviceToken {
            try? keychain.set(deviceToken, key: Constants.deviceToken)
        } else {
            try? keychain.remove(Constants.deviceToken)
        }
    }

    private func updateUserAuthorization(_ isAuthorized: String?) {
        if let isAuthorized = isAuthorized {
            try? keychain.set(isAuthorized, key: Constants.isUserAuthorized)
        } else {
            try? keychain.remove(Constants.isUserAuthorized)
        }
    }

    private func updateGrantType(grantType: String?) {
        if let grantType = grantType {
            try? keychain.set(grantType, key: Constants.grantType)
        } else {
            try? keychain.remove(Constants.grantType)
        }
    }

    public func canAuthentificate() -> Bool {
        accessToken != nil && refreshToken != nil
    }

}

private extension AuthStorage {
    // MARK: - User authorized
    @UserDefaultsEntry("isUserAuthorized", defaultValue: false)
    static var isUserAuthorized: Bool
}

private extension AuthStorage {
    // MARK: - First entry from start
    @UserDefaultsEntry("launchAuthorizationScreenShown", defaultValue: false)
    static var launchAuthorizationScreenShown: Bool
}
