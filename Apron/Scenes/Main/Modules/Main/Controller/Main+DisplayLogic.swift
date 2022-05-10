//
//  Main+DisplayLogic.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension MainViewController: MainDisplayLogic {
    
    // MARK: - MainDisplayLogic

    func displayJoinCommunity(viewModel: MainDataFlow.JoinCommunity.ViewModel) {
        state = viewModel.state
    }
}
