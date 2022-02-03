//
//  RecipeInformationCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25.01.2022.
//

import Foundation
import UIKit

protocol IRecipeInformationCellViewModel: AnyObject {
    var recipeName: String { get }
    var recipeSubtitle: String { get }
//    var recipeImage: String? { get }
    var recipeSourceURL: String? { get }
//    var likeCount: String { get }
//    var dislikeCount: String { get }
}

final class RecipeInformationCellViewModel: IRecipeInformationCellViewModel {
    var recipeName: String

    var recipeSubtitle: String

//    var recipeImage: String?

    var recipeSourceURL: String?

//    var likeCount: String

//    var dislikeCount: String

    init(
        recipeName: String,
        recipeSubtitle: String,
//        recipeImage: String?,
        recipeSourceURL: String?
//        likeCount: String,
//        dislikeCount: String
    ) {
        self.recipeName = recipeName
        self.recipeSubtitle = recipeSubtitle
//        self.recipeImage = recipeImage
        self.recipeSourceURL = recipeSourceURL
//        self.likeCount = likeCount
//        self.dislikeCount = dislikeCount
    }
}
