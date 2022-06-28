//
//  CommunitiesListPresenter.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

protocol CommunitiesListPresentationLogic: AnyObject {
    func getCommunities(response: CommunitiesListDataFlow.GetCommunities.Response)
    func joinCommunity(response: CommunitiesListDataFlow.JoinCommunity.Response)
}

final class CommunitiesListPresenter: CommunitiesListPresentationLogic {
    
    // MARK: - Properties
    weak var viewController: CommunitiesListDisplayLogic?
    
    // MARK: - CommunitiesListPresentationLogic

    func getCommunities(response: CommunitiesListDataFlow.GetCommunities.Response) {
        DispatchQueue.main.async {
            var viewModel: CommunitiesListDataFlow.GetCommunities.ViewModel

            defer { self.viewController?.displayCommunities(viewModel: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .fetchCommunities(model))
            case let .failed(error):
                viewModel = .init(state: .fetchCommunitiesFailed(error))
            }
        }
    }

    func joinCommunity(response: CommunitiesListDataFlow.JoinCommunity.Response) {
        DispatchQueue.main.async {
            var viewModel: CommunitiesListDataFlow.JoinCommunity.ViewModel

            defer { self.viewController?.displayJoinCommunity(viewModel: viewModel) }

            switch response.result {
            case .successfull:
                viewModel = .init(state: .joinedCommunity)
            case .failed:
                viewModel = .init(state: .joinedCommunityFailed)
            }
        }
    }
}
