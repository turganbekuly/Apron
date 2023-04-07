//
//  FeatureConfigHandler.swift
//  SnoonuRemoteConfig
//
//  Created by Arman Turalin on 04.02.2023.
//

import Foundation

protocol FeatureConfigHandler {
    var firebaseRemoteConfig: AppRemoteConfigProtocol { get }
    var abRemoteConfig: AppRemoteConfigProtocol { get }
    
    var firebaseKey: FirebaseKeyType { get }
    var abKey: ABKeyType { get }

    func config<T: RemoteConfigSerializable>(for key: ConfigKey<T>) -> T.T where T.T == T
}

//struct SnoomartHomepageV2FeatureHandler: FeatureConfigHandler {
//    var firebaseRemoteConfig: AppRemoteConfigProtocol
//    
//    var abRemoteConfig: AppRemoteConfigProtocol
//    
//    var firebaseKey: FirebaseKeyType {
//        .snoomartHomepageV2Enabled
//    }
//    
//    var abKey: ABKeyType {
//        .isSnoomartHomepageV2Enabled
//    }
//    
//    func config<T>(for key: ConfigKey<T>) -> T.T where T : RemoteConfigSerializable, T == T.Bridge.T {
//        let firebaseValue = firebaseRemoteConfig.config(for: firebaseKey.rawValue, defaultValue: key.defaultValue)
//        let abValue = abRemoteConfig.config(for: abKey.rawValue, defaultValue: key.defaultValue)
//        
//        guard let isEnabled = firebaseValue as? Bool, isEnabled else { return firebaseValue }
//        return abValue
//    }
//}
//
//struct LoyaltyProgramFeatureHandler: FeatureConfigHandler {
//    var firebaseRemoteConfig: AppRemoteConfigProtocol
//    
//    var abRemoteConfig: AppRemoteConfigProtocol
//    
//    var firebaseKey: FirebaseKeyType {
//        .iosLoyaltyProgramEnabled
//    }
//    
//    var abKey: ABKeyType {
//        .loyaltyProgram
//    }
//    
//    func config<T>(for key: ConfigKey<T>) -> T.T where T : RemoteConfigSerializable, T == T.Bridge.T {
//        let firebaseValue = firebaseRemoteConfig.config(for: firebaseKey.rawValue, defaultValue: key.defaultValue)
//        let abValue = abRemoteConfig.config(for: abKey.rawValue, defaultValue: key.defaultValue)
//        
//        guard let isFirebaseEnabled = firebaseValue as? Bool else { return firebaseValue }
//        guard let isABEnabled = abValue as? Bool else { return abValue }
//        
//        return (isFirebaseEnabled && isABEnabled) as? T.T ?? firebaseValue
//    }
//}
//
//struct ProductCardRedesignFeatureHandler: FeatureConfigHandler {
//    var firebaseRemoteConfig: AppRemoteConfigProtocol
//    
//    var abRemoteConfig: AppRemoteConfigProtocol
//    
//    var firebaseKey: FirebaseKeyType {
//        .productCardRedesign
//    }
//    
//    var abKey: ABKeyType {
//        .productCardRedesign
//    }
//    
//    func config<T>(for key: ConfigKey<T>) -> T.T where T : RemoteConfigSerializable, T == T.Bridge.T {
//        let firebaseValue = firebaseRemoteConfig.config(for: firebaseKey.rawValue, defaultValue: key.defaultValue)
//        let abValue = abRemoteConfig.config(for: abKey.rawValue, defaultValue: key.defaultValue)
//        
//        guard let isEnabled = firebaseValue as? Bool, isEnabled else { return firebaseValue }
//        return abValue
//    }
//}
//
//struct NewGroceryPageFeatureHandler: FeatureConfigHandler {
//    var firebaseRemoteConfig: AppRemoteConfigProtocol
//    
//    var abRemoteConfig: AppRemoteConfigProtocol
//    
//    var firebaseKey: FirebaseKeyType {
//        .newGroceryPageEnabled
//    }
//    
//    var abKey: ABKeyType {
//        .isNewGroceryPageEnabled
//    }
//    
//    func config<T>(for key: ConfigKey<T>) -> T.T where T : RemoteConfigSerializable, T == T.Bridge.T {
//        let firebaseValue = firebaseRemoteConfig.config(for: firebaseKey.rawValue, defaultValue: key.defaultValue)
//        let abValue = abRemoteConfig.config(for: abKey.rawValue, defaultValue: key.defaultValue)
//        
//        guard let isEnabled = firebaseValue as? Bool, isEnabled else { return firebaseValue }
//        return abValue
//    }
//}
//
//struct ProductRecommendationsFeatureHandler: FeatureConfigHandler {
//    var firebaseRemoteConfig: AppRemoteConfigProtocol
//    
//    var abRemoteConfig: AppRemoteConfigProtocol
//    
//    var firebaseKey: FirebaseKeyType {
//        .isProductRecommendationsEnabled
//    }
//    
//    var abKey: ABKeyType {
//        .isRecommendationsEnabled
//    }
//    
//    func config<T>(for key: ConfigKey<T>) -> T.T where T : RemoteConfigSerializable, T == T.Bridge.T {
//        let firebaseValue = firebaseRemoteConfig.config(for: firebaseKey.rawValue, defaultValue: key.defaultValue)
//        let abValue = abRemoteConfig.config(for: abKey.rawValue, defaultValue: key.defaultValue)
//        
//        guard let isEnabled = firebaseValue as? Bool, isEnabled else { return firebaseValue }
//        return abValue
//    }
//}
