//
//  ResultList+DisplayLogic.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension ResultListViewController: ResultListDisplayLogic {
    
    // MARK: - ResultListDisplayLogic

    func displayRecipesByCommunityID(with viewModel: ResultListDataFlow.GetRecipesByCommunityID.ViewModel) {
        state = viewModel.state
    }
    
}
