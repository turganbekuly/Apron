//
//  AuthStorage.swift
//  AKNetwork
//
//  Created by Akarys Turganbekuly on 07.01.2022.
//

import KeychainAccess
import Models

public protocol AuthStorageProtocol {
    var accessToken: String? { get set }
    var phoneNumber: String? { get set }
    var refreshToken: String? { get set }
    var deviceToken: String? { get set }
    func save(model: Auth)
    func clear()
    func canAuthentificate() -> Bool
}

public final class AuthStorage: AuthStorageProtocol {

    private enum Constants {
        static let accessToken = "accessToken"
        static let phoneNumber = "phoneNumber"
        static let pin = "pin"
        static let refreshToken = "refreshToken"
        static let deviceToken = "deviceToken"
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

    public var phoneNumber: String? {
        get { try? keychain.get(Constants.phoneNumber) }
        set { updatePhoneNumber(newValue) }
    }

    public var deviceToken: String? {
        get { try? keychain.get(Constants.deviceToken) }
        set { updateDeviceToken(newValue) }
    }

    // MARK: - Init

    public init() {
        keychain = Keychain()
    }

    // MARK: - Methods

    public func save(model: Auth) {
        accessToken = model.accessToken
        refreshToken = model.refreshToken
    }

    public func clear() {
        accessToken = nil
        refreshToken = nil
        phoneNumber = nil

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

    private func updatePhoneNumber(_ phoneNumber: String?) {
        if let phoneNumber = phoneNumber {
            try? keychain.set(phoneNumber, key: Constants.phoneNumber)
        } else {
            try? keychain.remove(Constants.phoneNumber)
        }
    }

    private func updateDeviceToken(_ deviceToken: String?) {
        if let deviceToken = deviceToken {
            try? keychain.set(deviceToken, key: Constants.deviceToken)
        } else {
            try? keychain.remove(Constants.deviceToken)
        }
    }

    public func canAuthentificate() -> Bool {
        accessToken != nil && refreshToken != nil
    }

}

