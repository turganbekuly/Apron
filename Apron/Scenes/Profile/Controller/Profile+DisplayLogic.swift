//
//  Profile+DisplayLogic.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/06/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension ProfileViewController: ProfileDisplayLogic {
    
    // MARK: - ProfileDisplayLogic

    func displayProfile(with viewModel: ProfileDataFlow.GetProfile.ViewModel) {
        state = viewModel.state
    }
}
