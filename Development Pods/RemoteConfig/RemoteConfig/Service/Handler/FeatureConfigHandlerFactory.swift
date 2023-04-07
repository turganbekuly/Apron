//
//  FeatureConfigHandlerFactory.swift
//  SnoonuRemoteConfig
//
//  Created by Arman Turalin on 04.02.2023.
//

import Foundation

extension ConfigurationManager {
    final class FeatureConfigHandlerFactory {
        static func createFeatureConfigHandlers(_ configurationManager: ConfigurationManager) -> [FeatureConfigHandler] {
            let firebaseRemoteConfig = configurationManager.firebaseRemoteConfig
//            let abRemoteConfig = configurationManager.abRemoteConfig
            
            return []
        }
    }
}
