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

    private static func getValue(for key: String) -> String? {
        return Bundle.main.object(forInfoDictionaryKey: key) as? String
    }

}

