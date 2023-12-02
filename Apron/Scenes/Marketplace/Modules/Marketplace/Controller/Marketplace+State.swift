//
//  Marketplace+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/10/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Models
import UIKit
import APRUIKit

extension MarketplaceViewController {
    
    // MARK: - State
    public enum State {
        case initial
        case getItemsSucceed([MarketplaceItemResponseBody])
        case getItemsFailed(AKNetworkError)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case .initial:
            getItems()
        case let .getItemsSucceed(model):
            self.items = model
            self.refreshControl.endRefreshing()
        case let .getItemsFailed(error):
            show(type: .error(L10n.Alert.errorMessage))
        }
    }
    
}
