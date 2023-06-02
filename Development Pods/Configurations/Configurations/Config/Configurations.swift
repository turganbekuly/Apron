//
//  Configurations.swift
//  Configurations
//
//  Created by Akarys Turganbekuly on 02.01.2022.
//

import Foundation

public final class Configurations {

    // MARK: - Init
    public init() {

    }

    // MARK: - Methods
    public static func getBaseURL() -> URL {
        guard let http = getValue(for: ConfigurationKeys.http),
              let urlString = getValue(for: ConfigurationKeys.baseURL),
              let url = URL(string: "\(http)\(urlString)") else {
            fatalError("Cannot get base url")
        }

        return url
    }

    public static func downloadImageURL(imagePath: String) -> String {
        return "\(getBaseURL())file/download?fileName=\(imagePath)"
    }

    public static func getWebBaseHost() -> String {
        getValue(for: ConfigurationKeys.webBasedURL) ?? ""
    }

    public static func getDeeplinkBaseURL() -> String {
        guard let urlString = getValue(for: ConfigurationKeys.deeplinkBasedURL) else {
            print("Cannot get base url")
            return ""
        }
        return "\(urlString)"
    }

    public static func getAppId() -> String {
        getValue(for: ConfigurationKeys.app_id) ?? ""
    }

    public static func getOneSignalAppID() -> String {
        getValue(for: ConfigurationKeys.oneSignalAppID) ?? ""
    }

    public static func getAmplitudeAPIKey() -> String {
        guard let apiKey = getValue(for: ConfigurationKeys.amplitudeApiKey) else {
            print("Cannot get api key")
            return ""
        }

        return apiKey
    }

    public static func getSentryURL() -> String {
        guard let urlString = getValue(for: ConfigurationKeys.sentryURL) else {
            print("Cannot get api key")
            return ""
        }

        return urlString
    }

    public static func getMixpanelAPIKey() -> String {
        guard let apiKey = getValue(for: ConfigurationKeys.mixpanelApiKey) else {
            print("Cannot get api key")
            return ""
        }

        return apiKey
    }
    
    public static func getOpenAIAPIKey() -> String {
        guard let apiKey = getValue(for: ConfigurationKeys.openAIApiKey) else {
            print("Cannot get api key")
            return ""
        }

        return apiKey
    }

    public static func getAppsflyerDevKey() -> String {
        guard let devKey = getValue(for: ConfigurationKeys.appsflyerDevKey) else {
            print("Cannot get dev key")
            return ""
        }

        return devKey
    }

    private static func getValue(for key: String) -> String? {
        return Bundle.main.object(forInfoDictionaryKey: key) as? String
    }

}
