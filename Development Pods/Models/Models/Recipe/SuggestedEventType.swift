//
//  SuggestedEventType.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04.10.2022.
//

import Foundation

public enum SuggestedEventType: Int, CaseIterable, Codable {
    case noviiGod = 1
    case xmas
    case svidanie
    case mensDay
    case womensday
    case paskha
    case masslenica

    public var title: String {
        switch self {
        case .noviiGod:
            return "Новый год"
        case .svidanie:
            return "Свидание"
        case .mensDay:
            return "День защитника отечества"
        case .xmas:
            return "Рождество"
        case .womensday:
            return "8 марта"
        case .paskha:
            return "Пасха"
        case .masslenica:
            return "Массленица"
        }
    }
}

