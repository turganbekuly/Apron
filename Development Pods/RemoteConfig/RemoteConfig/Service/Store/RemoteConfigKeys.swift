//
//  RemoteConfigKeys.swift
//  SnoonuRemoteConfig
//
//  Created by Arman Turalin on 10.02.2023.
//

import Foundation

public protocol RemoteConfigKeyStore {}

public struct RemoteConfigKeys: RemoteConfigKeyStore {
    public init() {}
}

public extension RemoteConfigKeys {
    static var isForceUpdateEnabled: ConfigKey<Bool> {
        .init(firebaseKey: .isForceUpdateEnabled, abKey: nil, defaultValue: false)
    }
    static var appVersion: ConfigKey<String> {
        .init(firebaseKey: .appVersion, abKey: nil, defaultValue: "")
    }
    static var isCookAssistantEnabled: ConfigKey<Bool> {
        .init(firebaseKey: .isCookAssistantEnabled, abKey: nil, defaultValue: false)
    }
    static var aboutCommunitiesLink: ConfigKey<String> {
        .init(firebaseKey: .aboutCommunitiesLink, abKey: nil, defaultValue: "")
    }
    static var orderFromStoreLink: ConfigKey<String> {
        .init(firebaseKey: .orderFromStoreLink, abKey: nil, defaultValue: "")
    }
    static var contactWithDevelopersLink: ConfigKey<String> {
        .init(firebaseKey: .contactWithDevelopersLink, abKey: nil, defaultValue: "")
    }
    static var occasionNumber: ConfigKey<Int> {
        .init(firebaseKey: .occasionNumber, abKey: nil, defaultValue: 0)
    }
    static var isGallerySourceEnabled: ConfigKey<Bool> {
        .init(firebaseKey: .isGallerySourceEnabled, abKey: nil, defaultValue: false)
    }
    static var isRecipeCreationEnabled: ConfigKey<Bool> {
        .init(firebaseKey: .isRecipeCreationEnabled, abKey: nil, defaultValue: true)
    }
    static var isPaidRecipeEnabled: ConfigKey<Bool> {
        .init(firebaseKey: .isPaidRecipeEnabled, abKey: nil, defaultValue: false)
    }
    static var adBannerObject: ConfigKey<[AdBannerObject]> {
        .init(firebaseKey: .adBannerObject, abKey: nil, defaultValue: [])
    }
}

public struct AdBannerObject: Codable, RemoteConfigSerializable {
    public let bannerLink: String
    public let bannerAction: String

    private enum CodingKeys: String, CodingKey {
        case bannerLink = "banner_link"
        case bannerAction = "banner_action"
    }
}
