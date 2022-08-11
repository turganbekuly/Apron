//
//  AddComment+DisplayLogic.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 30/07/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension AddCommentViewController: AddCommentDisplayLogic {
    // MARK: - AddCommentDisplayLogic

    func displayAddComment(viewModel: AddCommentDataFlow.AddComment.ViewModel) {
        state = viewModel.state
    }

    func displayRateRecipe(viewModel: AddCommentDataFlow.RateRecipe.ViewModel) {
        state = viewModel.state
    }

    func displayUploadImage(viewModel: AddCommentDataFlow.UploadImage.ViewModel) {
        state = viewModel.state
    }
}
