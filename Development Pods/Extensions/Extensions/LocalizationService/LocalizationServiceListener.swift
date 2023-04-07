//
//  LocalizationServiceListener.swift
//  Extensions
//
//  Created by Akarys Turganbekuly on 24.02.2023.
//

import Foundation

public enum LocalizationServiceEvent {
    case languageChanged(Language)
}

public protocol LocalizationServiceListener: AnyObject {
    func localizationServiceEvent(_ event: LocalizationServiceEvent)
}
