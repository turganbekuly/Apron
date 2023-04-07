//
//  SuggestedDayTimeType.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21.08.2022.
//

import Foundation

public enum SuggestedDayTimeType: Int, CaseIterable, Codable {
    case zavtrak = 1
    case obed
    case poldnik
    case uzhin
    case perekus

    public var title: String {
        switch self {
        case .zavtrak:
            return "Завтрак"
        case .obed:
            return "Обед"
        case .poldnik:
            return "Полдник"
        case .uzhin:
            return "Ужин"
        case .perekus:
            return "Перекус"
        }
    }
}
