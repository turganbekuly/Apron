//
//  StepByStepMode+DescriptionDelegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 30.08.2022.
//

import Foundation

extension StepByStepModeViewController: StepDescriptionCellProtocol {
    func timerDidFinish(stepNumber: Int) {
        print(stepNumber)
    }

    func ingredientsTapped() {
        // navigate to ingredients
    }
}
