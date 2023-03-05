//
//  RecipeCreationInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol RecipeCreationBusinessLogic {
    func createRecipe(request: RecipeCreationDataFlow.CreateRecipe.Request)
    func uploadImage(request: RecipeCreationDataFlow.UploadImage.Request)
}

final class RecipeCreationInteractor: RecipeCreationBusinessLogic {

    // MARK: - Properties
    private let presenter: RecipeCreationPresentationLogic
    private let provider: RecipeCreationProviderProtocol

    // MARK: - Initialization
    init(presenter: RecipeCreationPresentationLogic,
         provider: RecipeCreationProviderProtocol = RecipeCreationProvider()) {
        self.presenter = presenter
        self.provider = provider
    }

    // MARK: - RecipeCreationBusinessLogic

    func createRecipe(request: RecipeCreationDataFlow.CreateRecipe.Request) {
        provider.createRecipe(request: request) { [weak self] in
            switch $0 {
            case let .successful(model):
                self?.presenter.createRecipe(response: .init(result: .successful(model: model)))
            case let .failed(error):
                self?.presenter.createRecipe(response: .init(result: .failed(error: error)))
            }
        }
    }

    func uploadImage(request: RecipeCreationDataFlow.UploadImage.Request) {
        provider.uploadImage(request: request) { [weak self] in
            switch $0 {
            case let .successful(imagePath):
                self?.presenter.uploadImage(response: .init(result: .successful(imagePath: imagePath)))
            case let .failed(error):
                self?.presenter.uploadImage(response: .init(result: .failed(error: error)))
            }
        }
    }
}
