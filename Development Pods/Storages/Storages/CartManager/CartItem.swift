//
//  CartItem.swift
//  Storages
//
//  Created by Akarys Turganbekuly on 20.02.2022.
//

import Foundation
import Models

public struct CartItem: Codable {
    let id: Int
    let product: Product

    init(
        id: Int,
        product: Product
    ) {
        self.id = id
        self.product = product
    }
}
