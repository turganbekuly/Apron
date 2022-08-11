//
//  AddComment+Network.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 30/07/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models

extension AddCommentViewController {
    
    // MARK: - Network

    func rateRecipe(positive: Bool) {
        guard let recipeId = recipeId else { return }
        interactor.rateRecipe(
            request: .init(
                body: RatingRequestBody(recipeID: recipeId, isLiked: positive)
            )
        )
    }

    func addComment(body: AddCommentRequestBody) {
        interactor.addComment(request: .init(body: body))
    }

    func uploadImage(with image: UIImage) {
        interactor.uploadImage(request: .init(image: image))
    }
}
