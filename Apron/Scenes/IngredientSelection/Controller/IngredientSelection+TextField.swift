//
//  IngredientSelection+TextField.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09.05.2022.
//

import Foundation
import UIKit

extension IngredientSelectionViewController: MeasureInputViewProtocol {
    func measurementTextFieldDidChange(text: String?) {
        guard let _ = text else {
            configureSaveButtonEnabled(isEnabled: false)
            return
        }
        configureSaveButtonEnabled(isEnabled: true)
    }
}
