//
//  ContestResponse.swift
//  Models
//
//  Created by Акарыс Турганбекулы on 19.09.2023.
//

import Foundation

public struct ContestResponse: Codable {
    // MARK: - Private coding keys
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case date
    }
    
    public var id: Int? = 0
    public var name: String? = ""
    public var date: String? = ""
    
    // MARK: - Init
    
    public init() { }
    
    // MARK: - Methods
    
    public init?(json: JSON) {
        self.id = json[CodingKeys.id.rawValue] as? Int
        self.name = json[CodingKeys.name.rawValue] as? String
        self.date = json[CodingKeys.date.rawValue] as? String
    }
}
