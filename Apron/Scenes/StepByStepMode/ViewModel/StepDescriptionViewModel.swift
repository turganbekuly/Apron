//
//  StepDescriptionViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25.08.2022.
//

import Foundation
import Models

protocol StepDescriptionViewModelProtocol {
    var stepCount: Int { get }
    var recipeInstruction: RecipeInstruction? { get }
}

struct StepDescriptionViewModel: StepDescriptionViewModelProtocol {
    var stepCount: Int
    var recipeInstruction: RecipeInstruction?

}
