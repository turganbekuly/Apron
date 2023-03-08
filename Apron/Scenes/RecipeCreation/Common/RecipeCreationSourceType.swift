//
//  RecipeCreationSourceType.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 30.04.2022.
//

import Foundation

enum RecipeCreationSourceType: Equatable {
    case community(from: CommunityPageCreateRecipeProtocol)
    case saved
    case banner
    case planner
    case recipe
    case main

    static func ==(lhs: RecipeCreationSourceType, rhs: RecipeCreationSourceType) -> Bool {
        switch (lhs, rhs) {
        case (.community, .community):
            return true
        case (.main, .main):
            return true
        case (.banner, .banner):
            return true
        case (.saved, .saved):
            return true
        case (.planner, .planner):
            return true
        case (.recipe, .recipe):
            return true
        default:
            return false
        }
    }
}
