//
//  IngredientSelectionPresenter.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

protocol IngredientSelectionPresentationLogic: AnyObject {
    func getProducts(response: IngredientSelectionDataFlow.GetProducts.Response)
}

final class IngredientSelectionPresenter: IngredientSelectionPresentationLogic {

    // MARK: - Properties
    weak var viewController: IngredientSelectionDisplayLogic?

    // MARK: - IngredientSelectionPresentationLogic

    func getProducts(response: IngredientSelectionDataFlow.GetProducts.Response) {
        DispatchQueue.main.async {
            var viewModel: IngredientSelectionDataFlow.GetProducts.ViewModel

            defer { self.viewController?.displayProducts(viewModel: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .fetchProducts(model))
            case let .failed(error):
                viewModel = .init(state: .fetchProductsFailed(error))
            }
        }
    }
}
