//
//  SuggestedDishType.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04.10.2022.
//

import Foundation

public enum SuggestedDishType: Int, CaseIterable, Codable {
    case pervoeBluda = 1
    case vtoroeBluda
    case salati
    case zakuski
    case vipechka = 5
    case soucesAndMarinades
    case zagotovki
    case napitki
    case deserti
    case garniri = 10

    public var title: String {
        switch self {
        case .pervoeBluda:
            return "Первые блюда"
        case .vtoroeBluda:
            return "Вторые блюда"
        case .salati:
            return "Салаты"
        case .vipechka:
            return "Выпечка"
        case .deserti:
            return "Десерты"
        case .napitki:
            return "Напитки"
        case .zakuski:
            return "Закуски"
        case .zagotovki:
            return "Заготовки"
        case .soucesAndMarinades:
            return "Соусы и маринады"
        case .garniri:
            return "Гарниры"
        }
    }
}
