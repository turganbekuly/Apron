//
//  StepByStepMode+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 24/08/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

extension StepByStepModeViewController {
    
    // MARK: - State
    public enum State {
        case initial([RecipeInstruction])
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(instructions):
            self.instructions = instructions
        }
    }
    
}
