//
//  CommunityPage+DisplayLogic.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension CommunityPageViewController: CommunityPageDisplayLogic {
    
    // MARK: - CommunityPageDisplayLogic

    func displayCommunity(viewModel: CommunityPageDataFlow.GetCommunity.ViewModel) {
        state = viewModel.state
    }
}
