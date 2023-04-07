//
//  LocalizationService.swift
//  Extensions
//
//  Created by Akarys Turganbekuly on 24.02.2023.
//

import UIKit

public final class LocalizationService {
    // MARK: - Nested

    fileprivate struct Listener {
        weak var object: LocalizationServiceListener?
    }

    // MARK: - Variables

    public static let shared = LocalizationService()

    public var currentLanguage: Language {
        return Locale.current.selectedLanguage
    }

    public var isLanguageSelectedInApp: Bool {
        return UserDefaults.isUserSelectLanguage
    }

    fileprivate var listeners = [ObjectIdentifier: Listener]()

    // MARK: - Object Lifecycle

    private init() {
        Locale.setupInitialLanguage()
    }

    // MARK: - Work with Language changes

    public func changeLanguage(_ new: Language) {
        
    }
}
