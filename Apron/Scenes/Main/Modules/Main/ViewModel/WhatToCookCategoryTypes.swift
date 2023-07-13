//
//  WhatToCookCategoryTypes.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 16.10.2022.
//

import UIKit
import APRUIKit

enum WhatToCookCategoryTypes: CaseIterable {
    case pp
    case zavtrak
    case obed
    case uzhin
    case salati
    case deserti

    var title: String {
        switch self {
        case .zavtrak:
            return L10n.Food.CategoryType.breakfast
        case .obed:
            return L10n.Food.CategoryType.lunch
        case .uzhin:
            return L10n.Food.CategoryType.dinner
        case .salati:
            return L10n.Food.CategoryType.salads
        case .pp:
            return L10n.Food.CategoryType.pp
        case .deserti:
            return L10n.Food.CategoryType.deserts
        }
    }

    var image: UIImage {
        switch self {
        case .zavtrak:
            return APRAssets.breakfast.image
        case .obed:
            return APRAssets.obed.image
        case .uzhin:
            return APRAssets.uzhin.image
        case .salati:
            return APRAssets.salats.image
        case .pp:
            return APRAssets.zakuski.image
        case .deserti:
            return APRAssets.deserts.image
        }
    }
}
