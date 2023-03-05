//
//  TasteOnboarding+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit
import Models

extension TasteOnboardingViewController {

    // MARK: - State
    public enum State {
        case initial(TasteOnboardingScreenType, TasteOnboardingModel)
    }

    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(type, model):
            self.tasteOnboardingTypes = type
            self.tasteOnboardingModel = model
        }
    }

}
