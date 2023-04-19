//
//  GeneralSearchInitialState.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.05.2022.
//

import Foundation
import APRUIKit

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
            return L10n.GeneralSearchInitialState.Ru.everything
        case .recipe, .recipesFromCommunityPage, .savedRecipes:
            return L10n.GeneralSearchInitialState.Ru.recipe
        case .community:
            return L10n.GeneralSearchInitialState.Ru.community
        default:
            return nil
        }
    }

    var sections: String? {
        switch self {
        case .everything:
            return L10n.GeneralSearchInitialState.En.everything
        case .recipe, .recipesFromCommunityPage, .savedRecipes:
            return L10n.GeneralSearchInitialState.En.recipe
        case .community:
            return L10n.GeneralSearchInitialState.En.community
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
