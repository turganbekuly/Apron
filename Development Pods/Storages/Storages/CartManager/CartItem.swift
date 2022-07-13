//
//  CartItem.swift
//  Storages
//
//  Created by Akarys Turganbekuly on 20.02.2022.
//

import Foundation
import Models

public struct CartItem: Codable {
    public let productName: String
    public let productCategoryName: String
    public var recipeName: [String]?
    public var amount: Double?
    public var measurement: String?
    public var bought: Bool

    public init(
        productName: String,
        productCategoryName: String,
        amount: Double?,
        measurement: String?,
        recipeName: [String]?,
        bought: Bool
    ) {
        self.productName = productName
        self.productCategoryName = productCategoryName
        self.amount = amount
        self.measurement = measurement
        self.recipeName = recipeName
        self.bought = bought
    }
}
