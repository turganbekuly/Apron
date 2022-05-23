//
//  CommunityCreationPresenter.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

protocol CommunityCreationPresentationLogic: AnyObject {
    func createCommunity(response: CommunityCreationDataFlow.CreateCommunity.Response)
}

final class CommunityCreationPresenter: CommunityCreationPresentationLogic {
    
    // MARK: - Properties
    weak var viewController: CommunityCreationDisplayLogic?
    
    // MARK: - CommunityCreationPresentationLogic

    func createCommunity(response: CommunityCreationDataFlow.CreateCommunity.Response) {
        DispatchQueue.main.async {
            var viewModel: CommunityCreationDataFlow.CreateCommunity.ViewModel

            defer { self.viewController?.displayCreatedCommunity(with: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .communityCreationSucceed(model))
            case let .failed(error):
                viewModel = .init(state: .communityCreationFailed(error))
            }
        }
    }
}
