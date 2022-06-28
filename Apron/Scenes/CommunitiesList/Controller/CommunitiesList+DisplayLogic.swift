//
//  CommunitiesList+DisplayLogic.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension CommunitiesListViewController: CommunitiesListDisplayLogic {
    
    // MARK: - CommunitiesListDisplayLogic

    func displayCommunities(viewModel: CommunitiesListDataFlow.GetCommunities.ViewModel) {
        state = viewModel.state
    }

    func displayJoinCommunity(viewModel: CommunitiesListDataFlow.JoinCommunity.ViewModel) {
        state = viewModel.state
    }
}
