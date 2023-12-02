//
//  ShoppingListPresenter.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Storages
import UIKit

protocol ShoppingListPresentationLogic: AnyObject {
    func fetchCartItems(response: ShoppingListDataFlow.GetCartItems.Response)
    func clearCartItems(response: ShoppingListDataFlow.ClearCartItems.Response)
}

final class ShoppingListPresenter: ShoppingListPresentationLogic {

    // MARK: - Properties
    weak var viewController: ShoppingListDisplayLogic?

    // MARK: - ShoppingListPresentationLogic

    func fetchCartItems(response: ShoppingListDataFlow.GetCartItems.Response) {
        DispatchQueue.main.async {
            var viewModel: ShoppingListDataFlow.GetCartItems.ViewModel

            defer { self.viewController?.displayCartItems(viewModel: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .cartItemsDidFetch(model))
            case .failed:
                viewModel = .init(state: .cartItemsDidFail)
            }
        }
    }

    func clearCartItems(response: ShoppingListDataFlow.ClearCartItems.Response) {
        DispatchQueue.main.async {
            var viewModel: ShoppingListDataFlow.ClearCartItems.ViewModel

            defer { self.viewController?.displayClearCartItems(viewModel: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .cartItemsDidClear(model))
            case .failed:
                viewModel = .init(state: .cartItemsDidClearWithError)
            }
        }
    }
}
