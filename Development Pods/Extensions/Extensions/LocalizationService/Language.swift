//
//  Language.swift
//  Extensions
//
//  Created by Akarys Turganbekuly on 24.02.2023.
//

import Foundation

public enum Language: String {
    case english = "en"
    case russian = "ru"
    case kazakh = "kz"
}

public enum LanguageKey: String {
    case english = "Language.English"
    case russian = "Language.Russian"
    case kazakh = "Language.Kazakh"
}

public extension Language {
    private typealias Localizable = LanguageKey

    var name: String {
        switch self {
        case .english:
            return Localizable.english.localized()
        case .russian:
            return Localizable.russian.localized()
        case .kazakh:
            return Localizable.kazakh.localized()
        }
    }

    static var all: [Language] {
        return [.russian, .kazakh, .english]
    }
}

extension RawRepresentable where RawValue == String {
    func localized() -> String {
        return rawValue.localized()
    }

    func localized(values: [CVarArg]) -> String {
        return pluralLocalized(values: values)
    }

    func pluralLocalized(values: [CVarArg]) -> String {
        let localizedString = NSLocalizedString(rawValue, comment: rawValue)
        return String(format: localizedString, values)
    }
}

extension String {
    func localized() -> String {
        return NSLocalizedString(
            self,
            tableName: nil,
            bundle: Bundle.main,
            value: "",
            comment: ""
        )
    }
}
