//
//  RecipeCreationProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//


import Models

protocol RecipeCreationProviderProtocol {
    func createRecipe(
        request: RecipeCreationDataFlow.CreateRecipe.Request,
        compeletion: @escaping ((RecipeCreationDataFlow.CreateRecipeResult) -> Void)
    )
    func editRecipe(
        request: RecipeCreationDataFlow.CreateRecipe.Request,
        compeletion: @escaping ((RecipeCreationDataFlow.CreateRecipeResult) -> Void)
    )
    func uploadImage(
        request: RecipeCreationDataFlow.UploadImage.Request,
        completion: @escaping ((RecipeCreationDataFlow.UploadImageResult) -> Void)
    )
}

final class RecipeCreationProvider: RecipeCreationProviderProtocol {

    // MARK: - Properties
    private let service: RecipeCreationServiceProtocol

    // MARK: - Init
    init(service: RecipeCreationServiceProtocol =
                    RecipeCreationService(provider: AKNetworkProvider<RecipeCreationEndpoint>())) {
        self.service = service
    }

    // MARK: - RecipeCreationProviderProtocol

    func createRecipe(
        request: RecipeCreationDataFlow.CreateRecipe.Request,
        compeletion: @escaping ((RecipeCreationDataFlow.CreateRecipeResult) -> Void)
    ) {
        service.createRecipe(request: request) {
            switch $0 {
            case let .success(json):
                if let recipe = RecipeResponse(json: json) {
                    compeletion(.successful(model: recipe))
                } else {
                    compeletion(.failed(error: .invalidData))
                }
            case let .failure(error):
                compeletion(.failed(error: error))
            }
        }
    }

    func editRecipe(
        request: RecipeCreationDataFlow.CreateRecipe.Request,
        compeletion: @escaping ((RecipeCreationDataFlow.CreateRecipeResult) -> Void)
    ) {
        service.editRecipe(request: request) {
            switch $0 {
            case let .success(json):
                if let recipe = RecipeResponse(json: json) {
                    compeletion(.successful(model: recipe))
                } else {
                    compeletion(.failed(error: .invalidData))
                }
            case let .failure(error):
                compeletion(.failed(error: error))
            }
        }
    }

    func uploadImage(
        request: RecipeCreationDataFlow.UploadImage.Request,
        completion: @escaping ((RecipeCreationDataFlow.UploadImageResult) -> Void)
    ) {
        service.uploadImage(request: request) {
            switch $0 {
            case let .success(json):
                if let json = json["path"] as? String {
                    completion(.successful(imagePath: json))
                } else {
                    completion(.failed(error: .invalidData))
                }
            case let .failure(error):
                completion(.failed(error: error))
            }
        }
    }
}
