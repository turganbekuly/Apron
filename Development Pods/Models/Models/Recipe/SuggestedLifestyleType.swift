//
//  SuggestedLifestyleType.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04.10.2022.
//

import Foundation

public enum SuggestedLifestyleType: Int, CaseIterable, Codable {
    case halal = 1
    case vegan
    case vegetarian
    case pescatarian
    case kosher

    public var title: String {
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
