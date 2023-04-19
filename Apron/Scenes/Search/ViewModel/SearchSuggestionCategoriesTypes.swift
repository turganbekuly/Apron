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
    case firstMeal
    case secondMeal
    case salads
    case snacks
    case desserts
    case bakery
    case saucesMarinades
    case foodPrepProvision
    case drinks
    case sideDishes

    var title: String {
        switch self {
        case .firstMeal:
            return L10n.FoodCategories.FirstMeal.title
        case .secondMeal:
            return L10n.FoodCategories.SecondMeal.title
        case .salads:
            return L10n.FoodCategories.Salads.title
        case .snacks:
            return L10n.FoodCategories.Snacks.title
        case .desserts:
            return L10n.FoodCategories.Desserts.title
        case .bakery:
            return L10n.FoodCategories.Bakery.title
        case .saucesMarinades:
            return L10n.FoodCategories.SaucesMarinades.title
        case .foodPrepProvision:
            return L10n.FoodCategories.FoodPrepProvision.title
        case .drinks:
            return L10n.FoodCategories.Drinks.title
        case .sideDishes:
            return L10n.FoodCategories.SideDishes.title
        }
    }

    var image: UIImage {
        switch self {
        case .firstMeal:
            return APRAssets.firstCourseDish.image
        case .secondMeal:
            return APRAssets.vtorieBluda.image
        case .salads:
            return APRAssets.salats.image
        case .snacks:
            return APRAssets.zakuski.image
        case .desserts:
            return APRAssets.deserts.image
        case .bakery:
            return APRAssets.baking.image
        case .saucesMarinades:
            return APRAssets.souces.image
        case .foodPrepProvision:
            return APRAssets.zagotovki.image
        case .drinks:
            return APRAssets.napitki.image
        case .sideDishes:
            return APRAssets.sideDish.image
        }
    }

}
