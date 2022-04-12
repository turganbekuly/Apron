//
//  Product.swift
//  Storages
//
//  Created by Akarys Turganbekuly on 20.02.2022.
//

import Foundation

public struct Product: Codable {
    // MARK: - Coding Keys

    private enum CodingKeys: String, CodingKey {
        case id, name, image, protein, fat, carbs
    }

    // MARK: - Properties

    public let id: Int
    public let name: String?
    public let image: String?
    public let protein: String?
    public let fat: String?
    public let carbs: String?

    // MARK: - Init

    public init?(json: JSON) {
        guard let id = json[CodingKeys.id.rawValue] as? Int else {
            return nil
        }

        self.id = id
        self.name = json[CodingKeys.name.rawValue] as? String
        self.image = json[CodingKeys.image.rawValue] as? String
        self.protein = json[CodingKeys.protein.rawValue] as? String
        self.fat = json[CodingKeys.fat.rawValue] as? String
        self.carbs = json[CodingKeys.carbs.rawValue] as? String
    }
}
