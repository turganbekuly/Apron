//
//  ShoppingList+Network.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

extension ShoppingListViewController {

    // MARK: - Network

    func fetchCartItems() {
        interactor.fetchCartItems(request: .init())
    }

    func resetCartItems() {
        interactor.clearCartItems(request: .init())
    }

    func removeCartItem(with name: String, measurement: String?) {
        interactor.removeCartItem(with: name, measurement: measurement)
    }
}
