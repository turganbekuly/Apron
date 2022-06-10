//
//  TasteOnboardingViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05.01.2022.
//

import APRUIKit
import UIKit


struct TasteOnboardingViewModel {
    var text: String
    var type: TasteOnboardingScreenType

    // MARK: - Init

    init(text: String, type: TasteOnboardingScreenType) {
        self.text = text
        self.type = type
    }
}
