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
}
