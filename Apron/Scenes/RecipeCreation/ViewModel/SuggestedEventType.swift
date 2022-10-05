//
//  SuggestedEventType.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04.10.2022.
//

import Foundation

enum SuggestedEventType: Int, CaseIterable {
    case ramadan = 38
    case helloween
    case noviiGod
    case svidanie
    case mothersday
    case xmas
    case womensday
    case paskha
    case nauriz
    case bday

    var title: String {
        switch self {
        case .ramadan:
            return "Рамадан"
        case .helloween:
            return "Хэллоуин"
        case .noviiGod:
            return "Новый год"
        case .svidanie:
            return "Свидание"
        case .mothersday:
            return "День мамы"
        case .xmas:
            return "Рождество"
        case .womensday:
            return "8 марта"
        case .paskha:
            return "Пасха"
        case .nauriz:
            return "Наурыз"
        case .bday:
            return "День рождения"
        }
    }
}

