//
//  SearchByIngredientsPresenter.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19/08/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import UIKit
import Models

protocol SearchByIngredientsPresentationLogic: AnyObject {
    func getProductsByIds(response: SearchByIngredientsDataFlow.GetProductsByIDs.Response)
    func getProductsByName(response: SearchByIngredientsDataFlow.GetProductsByName.Response)
}

final class SearchByIngredientsPresenter: SearchByIngredientsPresentationLogic {
    
    // MARK: - Properties
    weak var viewController: SearchByIngredientsDisplayLogic?
    
    // MARK: - SearchByIngredientsPresentationLogic
    
    func getProductsByIds(response: SearchByIngredientsDataFlow.GetProductsByIDs.Response) {
        DispatchQueue.main.async {
            var viewModel: SearchByIngredientsDataFlow.GetProductsByIDs.ViewModel

            defer { self.viewController?.displayProductsByIds(viewModel: viewModel) }

            switch response.result {
            case let .success(model):
                viewModel = .init(state: .fetchedProductsByIds(model))
            case let .error(error):
                viewModel = .init(state: .fetchedProductsByIdsFailed(error))
            }
        }
    }
    
    func getProductsByName(response: SearchByIngredientsDataFlow.GetProductsByName.Response) {
        DispatchQueue.main.async {
            var viewModel: SearchByIngredientsDataFlow.GetProductsByName.ViewModel

            defer { self.viewController?.displayProductsByName(viewModel: viewModel) }

            switch response.result {
            case let .success(model):
                viewModel = .init(state: .fetchedProductsByName(model))
            case let .error(error):
                viewModel = .init(state: .fetchedProductsByNameFailed(error))
            }
        }
    }
}
