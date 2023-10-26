//
//  InformationCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25.01.2022.
//

import Foundation
import UIKit

protocol IInformationCellViewModel: AnyObject {
    var recipeName: String { get }
    var recipeImage: String? { get }
    var recipeAuthor: String? { get }
    var recipeSource: String? { get }
    var likeCount: Int { get }
    var dislikeCount: Int { get }
}

final class InformationCellViewModel: IInformationCellViewModel {
    var recipeName: String
    var recipeImage: String?
    var recipeAuthor: String?
    var recipeSource: String?
    var likeCount: Int
    var dislikeCount: Int

    init(
        recipeName: String,
        recipeImage: String?,
        recipeAuthor: String?,
        recipeSource: String?,
        likeCount: Int,
        dislikeCount: Int
    ) {
        self.recipeName = recipeName
        self.recipeImage = recipeImage
        self.recipeAuthor = recipeAuthor
        self.recipeSource = recipeSource
        self.likeCount = likeCount
        self.dislikeCount = dislikeCount
    }
}
