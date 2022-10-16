//
//  SuggestedDishType.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04.10.2022.
//

import Foundation

public enum SuggestedDishType: Int, CaseIterable, Codable {
    case zakuski = 6
    case salati
    case deserti
    case perekus
    case pervoeBluda
    case vtoroeBluda
    case gorBluda
    case vipechka
    case napitki
    case supi
    case zagotovki
    case varenie
    case povidlo
    case djemi
    case marinadi
    case solenya
    case bliniOladi
    case souces
    case garniri
    case PP
    case testo
    case hleb
    case torti
    case pirogi
    case pechene
    case kremi
    case detskoeMenu

    public var title: String {
        switch self {
        case .perekus:
            return "Перекус"
        case .pervoeBluda:
            return "Первые блюда"
        case .vtoroeBluda:
            return "Вторые блюда"
        case .gorBluda:
            return "Горячие блюда"
        case .salati:
            return "Салаты"
        case .vipechka:
            return "Выпечка"
        case .deserti:
            return "Десерты"
        case .napitki:
            return "Напитки"
        case .supi:
            return "Супы"
        case .zakuski:
            return "Закуски"
        case .zagotovki:
            return "Заготовки"
        case .varenie:
            return "Варенье"
        case .povidlo:
            return "Повидло"
        case .djemi:
            return "Джемы"
        case .marinadi:
            return "Маринады"
        case .solenya:
            return "Соленья"
        case .bliniOladi:
            return "Блины/Оладьи"
        case .souces:
            return "Соусы"
        case .garniri:
            return "Гарниры"
        case .PP:
            return "ПП"
        case .testo:
            return "Тесто"
        case .hleb:
            return "Хлеб"
        case .torti:
            return "Торты"
        case .pirogi:
            return "Пироги"
        case .pechene:
            return "Печенье"
        case .kremi:
            return "Кремы"
        case .detskoeMenu:
            return "Детское меню"
        }
    }
}

