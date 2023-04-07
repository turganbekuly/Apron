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
    case cookingTimeType(SuggestedCookingTimeType)
    case dayTimeType(SuggestedDayTimeType)
    case cuisine(RecipeCuisine)
    case dishType(SuggestedDishType)
    case ingredient(Product)
    case eventType(SuggestedEventType)
    case lifestyleType(SuggestedLifestyleType)
}

struct FilterOptionCellViewModel: FilterOptionCellViewModelProtocol {
    // MARK: - Properties

    private let type: FilterOptionType
    private let isSelected: Bool

    var backgroundColor: UIColor? {
        isSelected ? APRAssets.primaryTextMain.color : .white
    }

    var cellType: FilterOptionType {
        return type
    }

    var title: NSAttributedString? {
        var title = ""
        switch type {
        case .cookingTimeType(let suggestedCookingTimeType):
            title = suggestedCookingTimeType.title
        case .dayTimeType(let suggestedDayTimeType):
            title = suggestedDayTimeType.title
        case .cuisine(let recipeCuisine):
            title = recipeCuisine.name ?? ""
        case .dishType(let suggestedDishType):
            title = suggestedDishType.title
        case .ingredient(let product):
            title = product.name ?? ""
        case .eventType(let suggestedEventType):
            title = suggestedEventType.title
        case .lifestyleType(let suggestedLifestyleType):
            title = suggestedLifestyleType.title
        }
        return Typography.regular14(
            text: title,
            color: isSelected ? .white : .black,
            textAlignment: .center
        ).styled
    }

    // MARK: - Init

    public init(type: FilterOptionType, isSelected: Bool) {
        self.type = type
        self.isSelected = isSelected
    }
}
