//
//  RecipeIngredient.swift
//  Models
//
//  Created by Akarys Turganbekuly on 11.04.2022.
//

import Foundation

public struct RecipeIngredient: Codable {
    // MARK: - Coding Keys

    private enum CodingKeys: String, CodingKey {
        case product, amount, measurement
    }

    // MARK: - Properties

    public var product: Product?
    public var amount: String?
    public var measurement: String?

    // MARK: - Init

    public init() { }
    
    // MARK: - Methods

    public func toJSON() -> JSON {
        var params = JSON()
        if let product = product {
            params[CodingKeys.product.rawValue] = product
        }

        if let amount = amount {
            params[CodingKeys.amount.rawValue] = amount
        }

        if let measurement = measurement {
            params[CodingKeys.measurement.rawValue] = measurement
        }
        return params
    }
}

