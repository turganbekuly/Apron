//
//  GeneralSearchInitialState.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.05.2022.
//

import Foundation

public enum GeneralSearchInitialState: Equatable {
    case main
    case everything
    case recipe
    case community
    case savedRecipes
    case recipesFromCommunityPage(id: Int)

    var title: String? {
        switch self {
        case .everything:
            return "Все"
        case .recipe, .recipesFromCommunityPage, .savedRecipes:
            return "Рецепты"
        case .community:
            return "Сообщество"
        default:
            return nil
        }
    }

    var sections: String? {
        switch self {
        case .everything:
            return "Everything"
        case .recipe, .recipesFromCommunityPage, .savedRecipes:
            return "Recipes"
        case .community:
            return "Communities"
        default:
            return nil
        }
    }

    // MARK: - Methods

    public static func == (lhs: GeneralSearchInitialState, rhs: GeneralSearchInitialState) -> Bool {
        switch (lhs, rhs) {
        case (.main, .main):
            return true
        case (.everything, .everything):
            return true
        case (.recipe, .recipe):
            return true
        case (.community, .community):
            return true
        case (.savedRecipes, .savedRecipes):
            return true
        case (.recipesFromCommunityPage, .recipesFromCommunityPage):
            return true
        default:
            return false
        }
    }
}
