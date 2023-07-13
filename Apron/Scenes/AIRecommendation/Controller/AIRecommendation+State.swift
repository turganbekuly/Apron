//
//  AIRecommendation+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27/05/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Models
import UIKit

extension AIRecommendationViewController {
    
    // MARK: - State
    public enum State {
        case initial
        case getRecipes(SearchAIRecommendationResponseBody)
        case getRecipesFailed
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case .initial, .getRecipesFailed:
            break
        case let .getRecipes(model):
            print(model, "asdgamer")
            
        }
    }
    
}
