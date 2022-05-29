//
//  RecipeCreationSourceType.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 30.04.2022.
//

import Foundation

enum RecipeCreationSourceType {
    case community(id: Int, from: CommunityPageCreateRecipeProtocol)
    case saved
    case planner
    case recipe
}
