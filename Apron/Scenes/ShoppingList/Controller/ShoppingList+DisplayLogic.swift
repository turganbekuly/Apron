//
//  ShoppingList+DisplayLogic.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension ShoppingListViewController: ShoppingListDisplayLogic {
    
    // MARK: - ShoppingListDisplayLogic

    func displayCartItems(viewModel: ShoppingListDataFlow.GetCartItems.ViewModel) {
        state = viewModel.state
    }

    func displayClearCartItems(viewModel: ShoppingListDataFlow.ClearCartItems.ViewModel) {
        state = viewModel.state
    }
}
