//
//  MyRecipesPresenter.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22/01/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import UIKit

protocol MyRecipesPresentationLogic: AnyObject {
    func getProfileRecipes(response: MyRecipesDataFlow.GetMyRecipesData.Response)
}

final class MyRecipesPresenter: MyRecipesPresentationLogic {
    
    // MARK: - Properties
    weak var viewController: MyRecipesDisplayLogic?
    
    // MARK: - MyRecipesPresentationLogic

    func getProfileRecipes(response: MyRecipesDataFlow.GetMyRecipesData.Response) {
        DispatchQueue.main.async {
            var viewModel: MyRecipesDataFlow.GetMyRecipesData.ViewModel

            defer { self.viewController?.displayProfileRecipes(with: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .getProfileRecipeSucceed(model))
            case let .failed(error):
                viewModel = .init(state: .getProfileRecipeFailed(error))
            }
        }
    }
}
