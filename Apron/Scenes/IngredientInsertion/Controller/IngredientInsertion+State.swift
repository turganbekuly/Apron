//
//  IngredientInsertion+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

extension IngredientInsertionViewController {
    
    // MARK: - State
    public enum State {
        case initial(RecipeCreationAddIngredientCellProtocol?)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(delegate):
            self.delegate = delegate
        }
    }
    
}
