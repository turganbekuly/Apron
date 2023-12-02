//
//  IngredientSelection+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

enum IngredientSelectionInitialState {
    case onlyItem
    case fullItem
}
extension IngredientSelectionViewController {

    // MARK: - State
    public enum State {
        case initial(IngredientSelectedProtocol, IngredientSelectionInitialState)
        case fetchProducts([Product])
        case fetchProductsFailed(AKNetworkError)
    }

    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(delegate, initialState):
            self.initialState = initialState
            self.delegate = delegate
        case let .fetchProducts(model):
            self.products = model
        case let .fetchProductsFailed(error):
            print(error)
        }
    }

}
