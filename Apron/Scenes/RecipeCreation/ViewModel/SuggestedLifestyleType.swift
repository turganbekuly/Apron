//
//  SuggestedLifestyleType.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04.10.2022.
//

import Foundation

enum SuggestedLifestyleType: Int, CaseIterable {
    case halal = 33
    case vegan
    case vegetarian
    case pescatarian
    case kosher

    var title: String {
        switch self {
        case .halal:
            return "Халал"
        case .vegan:
            return "Веган"
        case .vegetarian:
            return "Вегетарианец"
        case .pescatarian:
            return "Пескетарианец"
        case .kosher:
            return "Кошерный"
        }
    }
}

