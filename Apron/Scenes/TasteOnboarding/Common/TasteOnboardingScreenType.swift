//
//  TasteOnboardingScreenType.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05.01.2022.
//

import Foundation

public enum TasteOnboardingScreenType: CaseIterable {
    case vegan
    case ingredients
    case cuisine

    var title: String {
        switch self {
        case .vegan:
            return "Вы вегетарианец(ка)?"
        case .ingredients:
            return "Какие ингредиенты предпочитаете?"
        case .cuisine:
            return "Какие кухни предпочитаете?"
        }
    }

    var text: [String] {
        switch self {
        case .vegan:
            return ["Показывать рецепты без мяса", "Показывать все рецепты"]
        case .ingredients:
            return ["Сыр", "Баклажан", "Картошка", "Яйца"]
        case .cuisine:
            return ["Азиатская", "Английская", "Грузинская", "Китайская"]
        }
    }
}
