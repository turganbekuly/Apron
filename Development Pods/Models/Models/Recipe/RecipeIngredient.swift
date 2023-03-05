//
//  RecipeIngredient.swift
//  Models
//
//  Created by Akarys Turganbekuly on 11.04.2022.
//

import Foundation

public struct RecipeIngredient: Codable, Equatable {
    // MARK: - Coding Keys

    private enum CodingKeys: String, CodingKey {
        case id
        case product = "product"
        case amount, measurement
    }

    // MARK: - Properties

    public var id: Int?
    public var product: Product?
    public var amount: Double?
    public var measurement: String?

    // MARK: - Init

    public init() { }

    public init?(json: JSON) {
        guard let id = json[CodingKeys.id.rawValue] as? Int else {
            return nil
        }

        self.id = id
        self.product = Product(json: json[CodingKeys.product.rawValue] as? JSON ?? [:])
        self.amount = json[CodingKeys.amount.rawValue] as? Double
        self.measurement = json[CodingKeys.measurement.rawValue] as? String
    }

    public static func ==(lhs: RecipeIngredient, rhs: RecipeIngredient) -> Bool {
        return lhs.id == rhs.id
    }

    // MARK: - Methods

    public func toJSON() -> JSON {
        var params = JSON()
        if let product = product {
            params["productId"] = product.id
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
