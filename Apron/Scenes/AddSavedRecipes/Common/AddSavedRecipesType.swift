//
//  AddSavedRecipesType.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 12.06.2022.
//

import Foundation

enum AddSavedRecipesType {
    case communityCreation(Int)
    case community(Int, CommunityPageCreateRecipeProtocol)
}
