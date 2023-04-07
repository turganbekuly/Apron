//
//  CategorySelection+DisplayLogic.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension CategorySelectionViewController: CategorySelectionDisplayLogic {
    // MARK: - CategorySelectionDisplayLogic

    func displayCategories(viewModel: CategorySelectionDataFlow.GetCategories.ViewModel) {
        state = viewModel.state
    }
}
