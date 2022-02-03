//
//  UserDefaultsStorage.swift
//  AlignedCollectionViewFlowLayout
//
//  Created by Akarys Turganbekuly on 06.01.2022.
//

import Foundation

@propertyWrapper
public struct UserDefaultsOptionalEntry<T> {
    public var wrappedValue: T? {
        get {
            userDefaults.object(forKey: key) as? T
        }
        set {
            userDefaults.set(newValue, forKey: key)
        }
    }

    private let key: String
    private let userDefaults: UserDefaults

    public init(_ key: String, userDefaults: UserDefaults = .standard) {
        self.key = key
        self.userDefaults = userDefaults
    }
}

@propertyWrapper
public struct UserDefaultsEntry<T> {
    public var wrappedValue: T {
        get {
            userDefaults.object(forKey: key) as? T ?? defaultValue
        }
        set {
            userDefaults.set(newValue, forKey: key)
        }
    }

    private let key: String
    private let defaultValue: T
    private let userDefaults: UserDefaults

    public init(_ key: String, defaultValue: T, userDefaults: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.userDefaults = userDefaults
    }
}

public struct UserDefaultsStorage {}

