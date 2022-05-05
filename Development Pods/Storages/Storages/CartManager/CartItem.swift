//
//  CartItem.swift
//  Storages
//
//  Created by Akarys Turganbekuly on 20.02.2022.
//

import Foundation
import Models

public struct CartItem: Codable {
    let productName: String
    var quantity: Double?
    var measurement: String?
    var recipeName: String?

    init(
        productName: String,
        quantity: Double?,
        measurement: String?,
        recipeName: String?
    ) {
        self.productName = productName
        self.quantity = quantity
        self.measurement = measurement
        self.recipeName = recipeName
    }
}
