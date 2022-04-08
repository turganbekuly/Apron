//
//  InstructionCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 29.01.2022.
//

import Foundation

struct InstructionInformations {
    var stepCount: String
    var stepDescription: String
}

protocol IInstructionCellViewModel: AnyObject {
    var instructions: [InstructionInformations] { get }
}

final class InstructionCellViewModel: IInstructionCellViewModel {
    // MARK: - Properties

    let instructions: [InstructionInformations]

    // MARK: - Init

    init(instructions: [InstructionInformations]) {
        self.instructions = instructions
    }
}
