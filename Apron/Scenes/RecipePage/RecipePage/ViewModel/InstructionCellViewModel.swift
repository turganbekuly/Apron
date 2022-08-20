//
//  InstructionCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 29.01.2022.
//

import Foundation
import Models

final class InstructionCellViewModel {
    // MARK: - Properties

    let instructions: [RecipeInstruction]

    // MARK: - Init

    init(instructions: [RecipeInstruction]) {
        self.instructions = instructions
    }
}
