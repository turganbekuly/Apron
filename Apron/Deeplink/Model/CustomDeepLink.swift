//
//  Deeplink.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07.06.2022.
//

enum CustomDeepLink: Equatable {
    case openCommunity(id: Int)
    case openRecipe(id: Int)
    case openShoppingList
    case openSavedRecipes
    case openMealPlanner
    case openRecipeCreation
    case unknown
}
