//
//  Marketplace+Network.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/10/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Models

extension MarketplaceViewController {
    
    // MARK: - Network

    func getItems() {
//        var item = MarketplaceItemResponseBody()
//        item.id = 1
//        item.name = "Sony PS5 chtobi bila vtoraya liniya asdaskdaskd"
//        item.price = 1000
//        item.maxCount = 10
//        item.stockCount = 1
//        
//        let items = Array(repeating: item, count: 10)
//        self.items = items
        
        
        interactor.getItems(request: .init())
    }
}
