//
//  StepByStepMode+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 24/08/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit
import OneSignal

protocol StepByStepFinalStepProtocol: AnyObject {
    func reviewButtonTapped()
}

extension StepByStepModeViewController {

    // MARK: - State
    public enum State {
        case initial([RecipeInstruction], String?, StepByStepFinalStepProtocol?, [RecipeIngredient])
    }

    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(instructions, finalImage, delegate, ingredients):
            self.ingredients = ingredients
            self.instructions = instructions
            self.finalImage = finalImage
            self.delegate = delegate
        }
    }

}
