//
//  InstructionsPage+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 29/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

extension InstructionsPageViewController {
    
    // MARK: - State
    public enum State {
        case initial
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case .initial:
            sections = [
                .init(section: .steps, rows: steps.compactMap { .step($0) })
            ]
        }
    }
    
}
