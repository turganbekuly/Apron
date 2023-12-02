//
//  MarketplaceItemResponseBody.swift
//  Models
//
//  Created by Акарыс Турганбекулы on 28.10.2023.
//

import Foundation

public struct MarketplaceItemResponseBody: Codable {
    // MARK: - Private Coding Keys
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case description
        case merchantSourceLink
        case price
        case maxCount
        case stockCount
    }
    
    // MARK: - Properties
    
    public var id: Int?
    public var name: String?
    public var image: String?
    public var description: String?
    public var merchantSourceLink: String?
    public var price: Int?
    public var maxCount: Int?
    public var stockCount: Int?
    
    // MARK: - Methods
    
    public init() { }
    
    public init?(json: JSON) {
        guard let id = json[CodingKeys.id.rawValue] as? Int else { return nil }

        self.id = id
        self.name = json[CodingKeys.name.rawValue] as? String
        self.image = json[CodingKeys.image.rawValue] as? String
        self.description = json[CodingKeys.description.rawValue] as? String
        self.merchantSourceLink = json[CodingKeys.merchantSourceLink.rawValue] as? String
        self.price = json[CodingKeys.price.rawValue] as? Int
        self.maxCount = json[CodingKeys.maxCount.rawValue] as? Int
        self.stockCount = json[CodingKeys.stockCount.rawValue] as? Int
    }
}
