//
//  InstructionSelection+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

extension InstructionSelectionViewController {
    
    // MARK: - State
    public enum State {
        case initial(InstructionSelectedProtocol)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(delegate):
            self.delegate = delegate
            sections = [.init(section: .instructions, rows: [.placeholder, .description])]
        }
    }
    
}
