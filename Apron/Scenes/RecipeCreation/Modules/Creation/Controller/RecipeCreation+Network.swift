//
//  RecipeCreation+Network.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models

extension RecipeCreationViewController {

    // MARK: - Network

    func createRecipe(recipe: RecipeCreation?) {
        guard let recipe = recipe else {
            return
        }

        interactor.createRecipe(request: .init(recipeCreation: recipe))
    }

    func editRecipe(recipe: RecipeCreation?) {
        guard let recipe = recipe else {
            return
        }

        interactor.editRecipe(request: .init(recipeCreation: recipe))
    }

    func uploadImage(with image: UIImage) {
        interactor.uploadImage(request: .init(image: image))
    }
}
