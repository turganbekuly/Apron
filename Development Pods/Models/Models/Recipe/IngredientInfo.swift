//
//  IngredientInfo.swift
//  Models
//
//  Created by Akarys Turganbekuly on 08.02.2022.
//

import Foundation

public struct IngredientInfo {
    public let ingredientName: String
    public let ingredientMeasurement: String?
    public let ingredientAmount: Double?

    public init(
        ingredientName: String,
        ingredientMeasurement: String?,
        ingredientAmount: Double?
    ) {
        self.ingredientName = ingredientName
        self.ingredientMeasurement = ingredientMeasurement
        self.ingredientAmount = ingredientAmount
    }
}
