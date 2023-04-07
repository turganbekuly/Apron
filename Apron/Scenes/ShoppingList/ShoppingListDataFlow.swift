//
//  ShoppingListDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Storages
import Models

enum ShoppingListDataFlow {

}

extension ShoppingListDataFlow {
    enum GetCartItems {
        struct Request {

        }
        struct Response {
            let result: GetCartItemsResponse
        }
        struct ViewModel {
            var state: ShoppingListViewController.State
        }
    }

    enum GetCartItemsResponse {
    case successful([CartItem])
    case failed(AKNetworkError)
    }
}

extension ShoppingListDataFlow {
    enum ClearCartItems {
        struct Request {

        }
        struct Response {
            let result: ClearCartItemsResponse
        }
        struct ViewModel {
            var state: ShoppingListViewController.State
        }
    }

    enum ClearCartItemsResponse {
    case successful([CartItem])
    case failed(AKNetworkError)
    }
}
