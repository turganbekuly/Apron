//
//  RecipeCreationInitialState.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 12.04.2022.
//

import Foundation
import Models

enum RecipeCreationInitialState {
    case edit(RecipeCreation, RecipeCreationSourceTypeModel)
    case create(RecipeCreation, RecipeCreationSourceTypeModel)
}
