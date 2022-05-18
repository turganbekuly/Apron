//
//  MainPresenter.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

protocol MainPresentationLogic: AnyObject {
    func joinCommunity(response: MainDataFlow.JoinCommunity.Response)
    func getCommunitiesByCategory(response: MainDataFlow.GetCommunities.Response)
    func getMyCommunities(response: MainDataFlow.GetMyCommunities.Response)
}

final class MainPresenter: MainPresentationLogic {
    
    // MARK: - Properties
    weak var viewController: MainDisplayLogic?
    
    // MARK: - MainPresentationLogic

    func joinCommunity(response: MainDataFlow.JoinCommunity.Response) {
        DispatchQueue.main.async {
            var viewModel: MainDataFlow.JoinCommunity.ViewModel

            defer { self.viewController?.displayJoinCommunity(viewModel: viewModel) }

            switch response.result {
            case .successfull:
                viewModel = .init(state: .joinedCommunity)
            case .failed:
                viewModel = .init(state: .joinedCommunityFailed)
            }
        }
    }

    func getCommunitiesByCategory(response: MainDataFlow.GetCommunities.Response) {
        DispatchQueue.main.async {
            var viewModel: MainDataFlow.GetCommunities.ViewModel

            defer { self.viewController?.displayCommunities(viewModel: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .fetchCommunitiesByCategory(model))
            case let .failed(error):
                viewModel = .init(state: .fetchCommunitiesByCategoryFailed(error))
            }
        }
    }

    func getMyCommunities(response: MainDataFlow.GetMyCommunities.Response) {
        DispatchQueue.main.async {
            var viewModel: MainDataFlow.GetMyCommunities.ViewModel

            defer { self.viewController?.displayMyCommunities(viewModel: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .fetchMyCommunities(model))
            case let .failed(error):
                viewModel = .init(state: .fetchMyCommunititesFailed(error))
            }
        }
    }
}
