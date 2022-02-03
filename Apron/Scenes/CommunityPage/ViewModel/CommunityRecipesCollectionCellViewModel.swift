//
//  CommunityRecipesCollectionCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19.01.2022.
//

import Foundation

protocol ICommunityRecipesCollectionCellViewModel: AnyObject {
    var recipeName: String { get }
    var cookingTime: String { get }
    var imageURL: String { get }
    var favCount: String { get }
    var userImage: String { get }
    var userName: String { get }
    var sourceURL: String { get }
    var postingTime: String { get }
}

final class CommunityRecipesCollectionCellViewModel: ICommunityRecipesCollectionCellViewModel {
    // MARK: - Properties

    var recipeName: String

    var cookingTime: String

    var imageURL: String

    var favCount: String

    var userImage: String

    var userName: String

    var sourceURL: String

    var postingTime: String

    init(
        recipeName: String,
        cookingTime: String,
        imageURL: String,
        favCount: String,
        userImage: String,
        userName: String,
        sourceURL: String,
        postingTime: String
    ) {
        self.recipeName = recipeName
        self.cookingTime = cookingTime
        self.imageURL = imageURL
        self.favCount = favCount
        self.userImage = userImage
        self.userName = userName
        self.sourceURL = sourceURL
        self.postingTime = postingTime
    }
}
