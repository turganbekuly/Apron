//
//  MarketplacePresenter.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/10/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import UIKit

protocol MarketplacePresentationLogic: AnyObject {
    func getItems(response: MarketplaceDataFlow.GetProducts.Response)
}

final class MarketplacePresenter: MarketplacePresentationLogic {
    
    // MARK: - Properties
    weak var viewController: MarketplaceDisplayLogic?
    
    // MARK: - MarketplacePresentationLogic
    
    func getItems(response: MarketplaceDataFlow.GetProducts.Response) {
        DispatchQueue.main.async {
            var viewModel: MarketplaceDataFlow.GetProducts.ViewModel

            defer { self.viewController?.displayItems(with: viewModel) }

            switch response.result {
            case let .success(model):
                viewModel = .init(state: .getItemsSucceed(model))
            case let .error(error):
                viewModel = .init(state: .getItemsFailed(error))
            }
        }
    }
}
