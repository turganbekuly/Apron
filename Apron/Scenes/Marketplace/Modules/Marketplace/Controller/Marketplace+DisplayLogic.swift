//
//  Marketplace+DisplayLogic.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/10/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import UIKit

extension MarketplaceViewController: MarketplaceDisplayLogic {
    
    // MARK: - MarketplaceDisplayLogic
    
    func displayItems(with viewModel: MarketplaceDataFlow.GetProducts.ViewModel) {
        state = viewModel.state
    }
}
