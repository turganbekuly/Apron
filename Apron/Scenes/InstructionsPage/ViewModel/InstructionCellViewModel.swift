//
//  InstructionCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 29.01.2022.
//

import Foundation

protocol IInstructionCellViewModel: AnyObject {
    var stepCount: String { get }
    var stepDescription: String { get }
}

final class InstructionCellViewModel: IInstructionCellViewModel {
    // MARK: - Properties

    var stepCount: String

    var stepDescription: String

    // MARK: - Init

    init(
        stepCount: String,
        stepDescription: String
    ) {
        self.stepCount = stepCount
        self.stepDescription = stepDescription
    }
}
