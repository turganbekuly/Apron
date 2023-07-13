//
//  AIRecommendationView.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 27.05.2023.
//

import UIKit
import APRUIKit

final class AIRecommendationView: View {
    //MARK: - Views factory
    
    private lazy var familyCount: RoundedTextField = {
        let textField = RoundedTextField(placeholder: "Кол-во членов семьи")
        textField.textField.keyboardType = .decimalPad
        return textField
    }()
    
    private lazy var dayCount: RoundedTextField = {
        let textField = RoundedTextField(placeholder: "На сколько дней составить план?")
        textField.textField.keyboardType = .decimalPad
        return textField
    }()
    
    private lazy var excludeIngredients: RoundedTextField = {
        let textField = RoundedTextField(placeholder: "На сколько дней составить план?")
        return textField
    }()
}
