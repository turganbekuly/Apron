//
//  IngredientsPage+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 29/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

extension IngredientsPageViewController {
    
    // MARK: - State
    public enum State {
        case initial
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case .initial:
           sections = [
            .init(section: .recipe, rows: descriptions.map { .description($0) }),
            .init(section: .recipe, rows: ingredients.map { .ingredients($0) })
           ]
        }
    }
    
}
