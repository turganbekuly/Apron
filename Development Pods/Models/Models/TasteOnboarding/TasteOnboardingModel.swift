//
//  TasteOnboardingModel.swift
//  AlignedCollectionViewFlowLayout
//
//  Created by Akarys Turganbekuly on 06.01.2022.
//

import Foundation

public struct TasteOnboardingModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case vegan, ingredients, cuisine
    }
    public var vegan: String = ""
    public var ingredients: [String] = []
    public var cuisine: [String] = []

    public init() {}

    public func toJSON() -> [String: Any] {
        var params = [String: Any]()
        params[CodingKeys.vegan.rawValue] = vegan
        params[CodingKeys.ingredients.rawValue] = ingredients.map { $0 }
        params[CodingKeys.cuisine.rawValue] = cuisine.map { $0 }
        return params
    }
}
