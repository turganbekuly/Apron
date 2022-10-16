//
//  FilterOptionCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09.10.2022.
//

import UIKit
import Models
import APRUIKit

protocol FilterOptionCellViewModelProtocol {
    var backgroundColor: UIColor? { get }
    var title: NSAttributedString? { get }
    var cellType: FilterOptionType { get }
}

enum FilterOptionType {
    case cookingTime(SuggestedCookingTime)
    case cuisine(RecipeCuisine)
    case dishType(SuggestedDishType)
    case ingredient(RecipeIngredient)
    case eventType(SuggestedEventType)
    case lifestyleType(SuggestedLifestyleType)
}

struct FilterOptionCellViewModel: FilterOptionCellViewModelProtocol {
    // MARK: - Properties

    private let type: FilterOptionType
    private let isSelected: Bool

    var backgroundColor: UIColor? {
        isSelected ? ApronAssets.colorsYello.color : .white
    }

    var cellType: FilterOptionType {
        return type
    }

    var title: NSAttributedString? {
        var title = ""
        switch type {
        case .cookingTime(let suggestedCookingTime):
            title = suggestedCookingTime.title
        case .cuisine(let recipeCuisine):
            title = recipeCuisine.name ?? ""
        case .dishType(let suggestedDishType):
            title = suggestedDishType.title
        case .ingredient(let recipeIngredient):
            title = recipeIngredient.product?.name ?? ""
        case .eventType(let suggestedEventType):
            title = suggestedEventType.title
        case .lifestyleType(let suggestedLifestyleType):
            title = suggestedLifestyleType.title
        }
        return Typography.regular14(
            text: title,
            color: .black,
            textAlignment: .center
        ).styled
    }

    // MARK: - Init

    public init(type: FilterOptionType, isSelected: Bool) {
        self.type = type
        self.isSelected = isSelected
    }
}
