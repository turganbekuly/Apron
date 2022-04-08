//
//  RecipePage+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

extension RecipePageViewController {
    
    // MARK: - State
    public enum State {
        case initial
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case .initial:
            sections = [
                .init(section: .topView, rows: topView.compactMap { .topView($0) }),
                .init(section: .ingredients, rows: ingredients.compactMap { .ingredient($0) }),
                .init(section: .instructions, rows: steps.compactMap { .instruction($0) })
            ]
        }
    }
    
}
