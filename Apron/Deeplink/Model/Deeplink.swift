//
//  Deeplink.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07.06.2022.
//

enum Deeplink: Equatable {
    case openCommunity(id: Int)
    case openRecipe(id: Int)
    case openShoppingList
    case openSavedRecipes
    case openPlanner
    case unknown
}