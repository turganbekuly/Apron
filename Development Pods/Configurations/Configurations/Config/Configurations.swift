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
        return "\(getBaseURL())image/download?fileName=\(imagePath)"
    }

    public static func getWebBaseHost() -> String {
        getValue(for: ConfigurationKeys.webBasedURL) ?? ""
    }

    public static func getDeeplinkBaseURL() -> String {
        guard let http = getValue(for: ConfigurationKeys.http),
              let urlString = getValue(for: ConfigurationKeys.deeplinkBasedURL) else {
            fatalError("Cannot get base url")
        }
        return "\(http)\(urlString)"
    }

    public static func getOneSignalAppID() -> String {
        getValue(for: ConfigurationKeys.oneSignalAppID) ?? ""
    }

    public static func getAmplitudeAPIKey() -> String {
        guard let apiKey = getValue(for: ConfigurationKeys.amplitudeApiKey) else {
            fatalError("Cannot get api key")
        }

        return apiKey
    }

    public static func getMixpanelAPIKey() -> String {
        guard let apiKey = getValue(for: ConfigurationKeys.mixpanelApiKey) else {
            fatalError("Cannot get api key")
        }

        return apiKey
    }

    private static func getValue(for key: String) -> String? {
        return Bundle.main.object(forInfoDictionaryKey: key) as? String
    }

}

