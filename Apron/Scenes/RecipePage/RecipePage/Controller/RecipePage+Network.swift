//
//  RecipePage+Network.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//
import Models

extension RecipePageViewController {

    // MARK: - Network

    func getRecipe(by id: Int) {
        interactor.getRecipe(request: .init(id: id))
    }

    func saveRecipe(with id: Int) {
        interactor.saveRecipe(request: .init(id: id))
    }

    func getComments(by id: Int) {
        interactor.getComments(request: .init(recipeId: id))
    }
    
    func getRecommendations(by id: Int) {
        interactor.getRecommendations(request: .init(recipeId: id))
    }
}
