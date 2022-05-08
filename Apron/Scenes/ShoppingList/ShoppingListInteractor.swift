//
//  ShoppingListInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Storages

protocol ShoppingListBusinessLogic {
    func fetchCartItems(request: ShoppingListDataFlow.GetCartItems.Request)
}

final class ShoppingListInteractor: ShoppingListBusinessLogic {
    
    // MARK: - Properties
    private let presenter: ShoppingListPresentationLogic
    private let provider: ShoppingListProviderProtocol
    
    // MARK: - Initialization
    init(presenter: ShoppingListPresentationLogic,
         provider: ShoppingListProviderProtocol = ShoppingListProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - ShoppingListBusinessLogic

    func fetchCartItems(request: ShoppingListDataFlow.GetCartItems.Request) {
        let cartItems = CartManager.shared.fetchItems()
        self.presenter.fetchCartItems(response: .init(result: .successful(cartItems)))
    }
}
