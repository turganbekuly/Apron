//
//  ShoppingListProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//



protocol ShoppingListProviderProtocol {

}

final class ShoppingListProvider: ShoppingListProviderProtocol {

    // MARK: - Properties
    private let service: ShoppingListServiceProtocol

    // MARK: - Init
    init(service: ShoppingListServiceProtocol =
                    ShoppingListService(provider: AKNetworkProvider<ShoppingListEndpoint>())) {
        self.service = service
    }

    // MARK: - ShoppingListProviderProtocol

}
