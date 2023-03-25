//
//  SearchSuggestionCategoriesTypes.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 16.10.2022.
//

import Foundation
import UIKit
import APRUIKit

enum SearchSuggestionCategoriesTypes: CaseIterable {
    case pervieBluda
    case vtorieBluda
    case salati
    case zakuski
    case deserti
    case vipechki
    case souciMarinadi
    case zagotovki
    case napitki
    case garniri

    var title: String {
        switch self {
        case .pervieBluda:
            return "Первые блюда"
        case .vtorieBluda:
            return "Вторые блюда"
        case .salati:
            return "Салаты"
        case .zakuski:
            return "Закуски"
        case .deserti:
            return "Десерты"
        case .vipechki:
            return "Выпечки"
        case .souciMarinadi:
            return "Соусы и маринады"
        case .zagotovki:
            return "Заготовки"
        case .napitki:
            return "Напитки"
        case .garniri:
            return "Гарниры"
        }
    }

    var image: UIImage {
        switch self {
        case .pervieBluda:
            return APRAssets.firstCourseDish.image
        case .vtorieBluda:
            return APRAssets.vtorieBluda.image
        case .salati:
            return APRAssets.salats.image
        case .zakuski:
            return APRAssets.zakuski.image
        case .deserti:
            return APRAssets.deserts.image
        case .vipechki:
            return APRAssets.baking.image
        case .souciMarinadi:
            return APRAssets.souces.image
        case .zagotovki:
            return APRAssets.zagotovki.image
        case .napitki:
            return APRAssets.napitki.image
        case .garniri:
            return APRAssets.sideDish.image
        }
    }

}
