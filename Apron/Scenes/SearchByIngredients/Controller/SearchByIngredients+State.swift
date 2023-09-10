//
//  SearchByIngredients+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19/08/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Models
import UIKit
import APRUIKit

extension SearchByIngredientsViewController {
    
    // MARK: - State
    public enum State {
        case initial
        case fetchedProductsByIds([Product])
        case fetchedProductsByIdsFailed(AKNetworkError)
        case fetchedProductsByName([Product])
        case fetchedProductsByNameFailed(AKNetworkError)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case .initial:
            getProductsByIds(ids: [290, 108, 219, 237, 272, 13, 99, 440, 211, 270, 16, 338, 195, 169, 343, 388])
            ApronAnalytics.shared.sendAnalyticsEvent(.searchByIngredientsViewed)
        case let .fetchedProductsByIds(products):
            self.suggestedProducts = products
        case .fetchedProductsByIdsFailed:
            show(type: .error(L10n.Alert.errorMessage))
        case let .fetchedProductsByName(products):
            self.products = products
        case .fetchedProductsByNameFailed:
            show(type: .error(L10n.Alert.errorMessage))
        }
    }
    
}
