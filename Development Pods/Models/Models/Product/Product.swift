//
//  Product.swift
//  Storages
//
//  Created by Akarys Turganbekuly on 20.02.2022.
//

import Foundation

public struct Product: Codable, Equatable {
    // MARK: - Coding Keys

    private enum CodingKeys: String, CodingKey {
        case id, name, image
        case proteinMass, fatMass, carbsMass
        case productCategoryName, description, kilokalori
    }

    // MARK: - Properties

    public var id: Int?
    public var name: String?
    public var productCategoryName: String?
    public var description: String?
    public var image: String?
    public var kilokalori: Double?
    public var proteinMass: Double?
    public var fatMass: Double?
    public var carbsMass: Double?

    // MARK: - Init

    public init() {}

    public init?(json: JSON) {
        guard let id = json[CodingKeys.id.rawValue] as? Int else {
            return nil
        }

        self.id = id
        self.name = json[CodingKeys.name.rawValue] as? String
        self.productCategoryName = json[CodingKeys.productCategoryName.rawValue] as? String
        self.description = json[CodingKeys.description.rawValue] as? String
        self.image = json[CodingKeys.image.rawValue] as? String
        self.kilokalori = json[CodingKeys.kilokalori.rawValue] as? Double
        self.proteinMass = json[CodingKeys.proteinMass.rawValue] as? Double
        self.fatMass = json[CodingKeys.fatMass.rawValue] as? Double
        self.carbsMass = json[CodingKeys.carbsMass.rawValue] as? Double
    }

    // MARK: - Methods

    public static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}
