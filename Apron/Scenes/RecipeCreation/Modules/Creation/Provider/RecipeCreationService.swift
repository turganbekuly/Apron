//
//  RecipeCreationService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//



protocol RecipeCreationServiceProtocol {
    func createRecipe(
        request: RecipeCreationDataFlow.CreateRecipe.Request,
        completion: @escaping ((AKResult) -> Void)
    )
    func editRecipe(
        request: RecipeCreationDataFlow.CreateRecipe.Request,
        completion: @escaping ((AKResult) -> Void)
    )
    func uploadImage(
        request: RecipeCreationDataFlow.UploadImage.Request,
        completion: @escaping ((AKResult) -> Void)
    )
}

final class RecipeCreationService: RecipeCreationServiceProtocol {

    // MARK: - Properties
    private let provider: AKNetworkProvider<RecipeCreationEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<RecipeCreationEndpoint>) {
        self.provider = provider
    }

    // MARK: - RecipeCreationServiceProtocol

    func createRecipe(
        request: RecipeCreationDataFlow.CreateRecipe.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(
            target: .createRecipe(request.recipeCreation)) { result in
                completion(result)
            }
    }

    func editRecipe(
        request: RecipeCreationDataFlow.CreateRecipe.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(
            target: .editRecipe(request.recipeCreation)) { result in
                completion(result)
            }
    }

    func uploadImage(
        request: RecipeCreationDataFlow.UploadImage.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        guard let data = request.image.jpeg(.medium) else {
            completion(.failure(.invalidData))
            return
        }

        provider.send(target: .uploadImage(image: data)) { result in
            completion(result)
        }
    }
}
