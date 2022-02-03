//
//  RecipeInitialState.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25.01.2022.
//

import Foundation

enum RecipeInitialState: Equatable {
    case ingredients
    case instruction
    case calories

    var title: String {
        switch self {
        case .ingredients:
            return "Ингредиенты"
        case .instruction:
            return "Инструкция"
        case .calories:
            return "Калорийность"
        }
    }

    // MARK: - Methods

    static func ==(lhs: RecipeInitialState, rhs: RecipeInitialState) -> Bool {
        switch (lhs, rhs) {
        case (.ingredients, .ingredients):
            return true
        case (.instruction, .instruction):
            return true
        case (.calories, .calories):
            return true
        default:
            return false
        }
    }
}
