//
//  CommunityPagePresenter.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

protocol CommunityPagePresentationLogic: AnyObject {
    func getCommunity(response: CommunityPageDataFlow.GetCommunity.Response)
}

final class CommunityPagePresenter: CommunityPagePresentationLogic {
    
    // MARK: - Properties
    weak var viewController: CommunityPageDisplayLogic?
    
    // MARK: - CommunityPagePresentationLogic

    func getCommunity(response: CommunityPageDataFlow.GetCommunity.Response) {
        DispatchQueue.main.async {
            var viewModel: CommunityPageDataFlow.GetCommunity.ViewModel

            defer { self.viewController?.displayCommunity(viewModel: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .displayCommunity(model))
            case let .failed(error):
                viewModel = .init(state: .displayCommunityError(error))
            }
        }
    }
}
