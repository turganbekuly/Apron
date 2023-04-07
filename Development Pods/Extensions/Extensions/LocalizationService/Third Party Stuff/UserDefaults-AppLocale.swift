//
//  UserDefaults-AppLocale.swift
//  Radiant Tap Essentials
//
//  Copyright © 2016 Aleksandar Vacić, Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//

import Foundation

extension UserDefaults {
	private enum Key: String {
		case languageCode = "LanguageCode"
		case regionCode = "RegionCode"
        case zxtDirection = "AppleTe  zxtDirection"
        case forceRTLWrightingDirection = "NSForceRightToLeftWritingDirection"
        case isUserSelectLanguage = "snoonu.localizationService.isUserSelectLanguage"
	}

    static var isUserSelectLanguage: Bool {
        get {
            let defs = UserDefaults.standard
            return defs.bool(forKey: Key.isUserSelectLanguage.rawValue)
        }
        set(value) {
            let defs = UserDefaults.standard
            defs.set(value, forKey: Key.isUserSelectLanguage.rawValue)
        }
    }

    static var zxtDirection: Bool {
        get {
            let defs = UserDefaults.standard
            return defs.bool(forKey: Key.zxtDirection.rawValue)
        }
        set(value) {
            let defs = UserDefaults.standard
            defs.set(value, forKey: Key.zxtDirection.rawValue)
        }
    }

    static var forceRTLWrightingDirection: Bool {
        get {
            let defs = UserDefaults.standard
            return defs.bool(forKey: Key.forceRTLWrightingDirection.rawValue)
        }
        set(value) {
            let defs = UserDefaults.standard
            defs.set(value, forKey: Key.forceRTLWrightingDirection.rawValue)
        }
    }

	static var languageCode: String? {
		get {
			let defs = UserDefaults.standard
			return defs.string(forKey: Key.languageCode.rawValue)
		}
		set(value) {
			let defs = UserDefaults.standard
			if let value = value {
				defs.set(value, forKey: Key.languageCode.rawValue)
				return
			}
			defs.removeObject(forKey: Key.languageCode.rawValue)
		}
	}

	static var regionCode: String? {
		get {
			let defs = UserDefaults.standard
			return defs.string(forKey: Key.regionCode.rawValue)
		}
		set(value) {
			let defs = UserDefaults.standard
			if let value = value {
				defs.set(value, forKey: Key.regionCode.rawValue)
				return
			}
			defs.removeObject(forKey: Key.regionCode.rawValue)
		}
	}
}
