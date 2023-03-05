//
//  ShoppingListService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol ShoppingListServiceProtocol {

}

final class ShoppingListService: ShoppingListServiceProtocol {

    // MARK: - Properties
    private let provider: AKNetworkProvider<ShoppingListEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<ShoppingListEndpoint>) {
        self.provider = provider
    }

    // MARK: - ShoppingListServiceProtocol

}
