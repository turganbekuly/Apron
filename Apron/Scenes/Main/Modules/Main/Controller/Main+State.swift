//
//  Main+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit
import DesignSystem

extension MainViewController {
    
    // MARK: - State
    public enum State {
        case initial
        case joinedCommunity
        case joinedCommunityFailed
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case .initial:
            recipes = myRecipes
        case .joinedCommunity:
            print("")
        case .joinedCommunityFailed:
            print("")
        }
    }
    
}
