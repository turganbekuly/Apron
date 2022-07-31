//
//  RecipePageReviewsViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22.07.2022.
//

import Foundation
import Models

protocol RecipePageReviewsViewModelProtocol {
    var comment: RecipeCommentResponse? { get }
}

struct RecipePageReviewsViewModel: RecipePageReviewsViewModelProtocol {
    let comment: RecipeCommentResponse?
}
