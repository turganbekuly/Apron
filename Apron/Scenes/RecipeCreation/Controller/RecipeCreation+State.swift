//
//  RecipeCreation+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

extension RecipeCreationViewController {
    
    // MARK: - State
    public enum State {
        case initial(RecipeCreationInitialState)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case .initial:
            sections = [
                .init(
                    section: .info,
                    rows: [
                        .name, .imagePlaceholder, .description,
                        .composition, .instruction, .servings,
                        .prepTime, .cookTime
                    ]
                )
            ]
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                self.replacePlaceholderCell()
            }
        }
    }
    
}
