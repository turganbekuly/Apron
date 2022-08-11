//
//  AssignTypes.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.04.2022.
//

import Foundation

enum AssignTypes {
    case servings(String)
    case prepTime(String)
    case cookTime(String)
    case whenToCook(Int)
}

enum SuggestedCookingTime: Int {
    case zavtrak = 1
    case obed = 2
    case poldnik = 3
    case uzhin = 4
    case pozdniiUzhin = 5
    case anytime = 6

    var title: String {
        switch self {
        case .zavtrak:
            return "Завтрак"
        case .obed:
            return "Обед"
        case .poldnik:
            return "Полдник"
        case .uzhin:
            return "Ужин"
        case .pozdniiUzhin:
            return "Поздний ужин"
        case .anytime:
            return "В любое время"
        }
    }
}
