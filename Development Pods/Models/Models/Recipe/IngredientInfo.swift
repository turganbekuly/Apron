//
//  IngredientInfo.swift
//  Models
//
//  Created by Akarys Turganbekuly on 08.02.2022.
//

import Foundation

public struct IngredientInfo {
    public let ingredientImage: String?
    public let ingredientName: String
    public let ingredientMeasurement: String?
    public let ingredientAmount: String?

    public init(
        ingredientImage: String?,
        ingredientName: String,
        ingredientMeasurement: String?,
        ingredientAmount: String?
    ) {
        self.ingredientImage = ingredientImage
        self.ingredientName = ingredientName
        self.ingredientMeasurement = ingredientMeasurement
        self.ingredientAmount = ingredientAmount
    }
}
