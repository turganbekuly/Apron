//
//  AssignBottomSheet+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

extension AssignBottomSheetViewController {

    // MARK: - State
    public enum State {
        case initial(AssignTypes, AssignTypesSelectedDelegate)
    }

    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(type, delegate):
            self.type = type
            self.delegate = delegate
        }
    }

}
