//
//  RemoteConfigManager.swift
//  RemoteConfig
//
//  Created by Akarys Turganbekuly on 18.06.2022.
//

import Foundation

public class RemoteConfigManager {
    // MARK: - Static properties

    public static let shared = RemoteConfigManager()

    // MARK: - Public properties

    public var remoteConfig = RemoteConfig()

    // MARK: - Init

    private init() { }
}
