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
            case let .failed(error):
                viewModel = .init(state: .cartItemsDidFail(error))
            }
        }
    }
}
