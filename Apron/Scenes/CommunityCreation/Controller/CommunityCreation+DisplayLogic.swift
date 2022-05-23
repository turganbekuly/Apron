//
//  CommunityCreation+DisplayLogic.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension CommunityCreationViewController: CommunityCreationDisplayLogic {
    
    // MARK: - CommunityCreationDisplayLogic

    func displayCreatedCommunity(with viewModel: CommunityCreationDataFlow.CreateCommunity.ViewModel) {
        state = viewModel.state
    }
}
