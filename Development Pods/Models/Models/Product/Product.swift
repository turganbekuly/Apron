//
//  Product.swift
//  Storages
//
//  Created by Akarys Turganbekuly on 20.02.2022.
//

import Foundation

public struct Product: Codable {
    public let id: Int
    public let name: String
    public let image: String
    public let protein: String
    public let fat: String
    public let carbs: String
}
