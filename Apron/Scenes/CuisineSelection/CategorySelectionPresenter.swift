//
//  CategorySelectionPresenter.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

protocol CategorySelectionPresentationLogic: AnyObject {
    func getCategories(response: CategorySelectionDataFlow.GetCategories.Response)
}

final class CategorySelectionPresenter: CategorySelectionPresentationLogic {

    // MARK: - Properties
    weak var viewController: CategorySelectionDisplayLogic?

    // MARK: - CategorySelectionPresentationLogic

    func getCategories(response: CategorySelectionDataFlow.GetCategories.Response) {
        DispatchQueue.main.async {
            var viewModel: CategorySelectionDataFlow.GetCategories.ViewModel

            defer { self.viewController?.displayCategories(viewModel: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .displayCategories(model: model))
            case let .failed(error):
                viewModel = .init(state: .displayCategoriesFailed(error: error))
            }
        }
    }
}
