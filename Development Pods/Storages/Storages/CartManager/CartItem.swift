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
    public let quantity: Int
    public var recipeName: [String]?
    public var amount: Double?
    public var measurement: String?

    public init(
        productName: String,
        amount: Double?,
        quantity: Int,
        measurement: String?,
        recipeName: [String]?
    ) {
        self.productName = productName
        self.amount = amount
        self.quantity = quantity
        self.measurement = measurement
        self.recipeName = recipeName
    }
}
