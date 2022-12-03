//
//  SuggestedCookingTimeType.swift
//  Models
//
//  Created by Akarys Turganbekuly on 17.10.2022.
//

import Foundation

public enum SuggestedCookingTimeType: Int, CaseIterable, Codable {
    case do15Min = 1
    case do30Min
    case do45Min
    case do1Chasu
    case bolsheChasa

    public var title: String {
        switch self {
        case .do15Min:
            return "До 15 мин"
        case .do30Min:
            return "До 30 мин"
        case .do45Min:
            return "До 45 мин"
        case .do1Chasu:
            return "До часа"
        case .bolsheChasa:
            return "Больше часа"
        }
    }
}
