//
//  ResultListPresenter.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

protocol ResultListPresentationLogic: AnyObject {
    func getRecipesByCommunityID(
        response: ResultListDataFlow.GetRecipesByCommunityID.Response
    )
}

final class ResultListPresenter: ResultListPresentationLogic {
    
    // MARK: - Properties
    weak var viewController: ResultListDisplayLogic?
    
    // MARK: - ResultListPresentationLogic

    func getRecipesByCommunityID(response: ResultListDataFlow.GetRecipesByCommunityID.Response) {
        DispatchQueue.main.async {
            var viewModel: ResultListDataFlow.GetRecipesByCommunityID.ViewModel

            defer { self.viewController?.displayRecipesByCommunityID(with: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .fetchRecipesByCommunityId(model))
            case let .failed(error):
                viewModel = .init(state: .fetchRecipesByCommunityIdFailed(error))
            }
        }
    }
}
