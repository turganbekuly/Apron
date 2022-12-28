//
//  Bundle+Version.swift
//  Extensions
//
//  Created by Akarys Turganbekuly on 18.06.2022.
//

import Foundation

extension Bundle {
    public var appVersion: String {
        if let result = infoDictionary?["CFBundleShortVersionString"] as? String {
            return result
        } else {
            assert(false)
            return ""
        }
    }

    public var buildVersion: String {
        if let result = infoDictionary?["CFBundleVersion"] as? String {
            return result
        } else {
            assert(false)
            return ""
        }
    }

    public var fullVersion: String {
        return "\(appVersion)(\(buildVersion))"
    }
}

