//
//  StepByStepMode+Sections.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 23.08.2023.
//

import UIKit
import Models

extension StepByStepModeViewController {
    struct Section {
        enum Section {
            case ingredients
            case instructions
            case review
        }
        enum Row {
            case ingredient([RecipeIngredient])
            case instruction(RecipeInstruction)
            case review
        }
        
        let section: Section
        let rows: [Row]
    }
    
    struct StepperSection {
        enum Section {
            case ingredients
            case steps
            case review
        }
        enum Row {
            case ingredient
            case step
            case review
        }
        let section: Section
        let rows: [Row]
    }
    
    enum CookingSection: Int {
        case ingredients = 0
        case instructions = 1
        case review = 2
    }
}
