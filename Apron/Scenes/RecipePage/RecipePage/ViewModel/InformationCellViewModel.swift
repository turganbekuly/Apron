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
//    var recipeImage: String? { get }
    var recipeSourceURL: String? { get }
    var likeCount: Int { get }
    var dislikeCount: Int { get }
}

final class InformationCellViewModel: IInformationCellViewModel {
    var recipeName: String

//    var recipeImage: String?

    var recipeSourceURL: String?

    var likeCount: Int

    var dislikeCount: Int

    init(
        recipeName: String,
//        recipeImage: String?,
        recipeSourceURL: String?,
        likeCount: Int,
        dislikeCount: Int
    ) {
        self.recipeName = recipeName
//        self.recipeImage = recipeImage
        self.recipeSourceURL = recipeSourceURL
        self.likeCount = likeCount
        self.dislikeCount = dislikeCount
    }
}
