//
//  WhatToCookCategoryTypes.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 16.10.2022.
//

import UIKit
import APRUIKit

enum WhatToCookCategoryTypes: CaseIterable {
    case zavtrak
    case obed
    case uzhin
    case salati
    case zakuski
    case deserti

    var title: String {
        switch self {
        case .zavtrak:
            return "Завтрак"
        case .obed:
            return "Обед"
        case .uzhin:
            return "Ужин"
        case .salati:
            return "Салаты"
        case .zakuski:
            return "Закуски"
        case .deserti:
            return "Десерты"
        }
    }

    var image: UIImage {
        switch self {
        case .zavtrak:
            return ApronAssets.breakfast.image
        case .obed:
            return ApronAssets.obed.image
        case .uzhin:
            return ApronAssets.uzhin.image
        case .salati:
            return ApronAssets.salats.image
        case .zakuski:
            return ApronAssets.zakuski.image
        case .deserti:
            return ApronAssets.deserts.image
        }
    }
}
