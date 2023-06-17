//
//  MyRecipesService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22/01/2023.
//  Copyright © 2023 Apron. All rights reserved.
//



protocol MyRecipesServiceProtocol {
    func getProfile(
        request: MyRecipesDataFlow.GetMyRecipesData.Request,
        completion: @escaping ((AKResult) -> Void)
    )
}

final class MyRecipesService: MyRecipesServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<MyRecipesEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<MyRecipesEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - MyRecipesServiceProtocol

    func getProfile(request: MyRecipesDataFlow.GetMyRecipesData.Request, completion: @escaping ((AKResult) -> Void)) {
        provider.send(target: .myRecipes) { result in
            completion(result)
        }
    }
}
