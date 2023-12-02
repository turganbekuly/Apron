//
//  MarketplaceDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/10/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Models

enum MarketplaceDataFlow { }

extension MarketplaceDataFlow {
    enum GetProducts {
        struct Request {
            
        }
        struct Response {
            let result: GetProductsResult
        }
        struct ViewModel {
            var state: MarketplaceViewController.State
        }
    }
    
    enum GetProductsResult {
        case success([MarketplaceItemResponseBody])
        case error(AKNetworkError)
    }
}
