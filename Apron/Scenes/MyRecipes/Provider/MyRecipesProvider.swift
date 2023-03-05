//
//  MyRecipesProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22/01/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import AKNetwork
import Models

protocol MyRecipesProviderProtocol {
    func getProfile(
        request: MyRecipesDataFlow.GetMyRecipesData.Request,
        completion: @escaping ((MyRecipesDataFlow.MyRecipesResults) -> Void)
    )
}

final class MyRecipesProvider: MyRecipesProviderProtocol {

    // MARK: - Properties
    private let service: MyRecipesServiceProtocol
    
    // MARK: - Init
    init(service: MyRecipesServiceProtocol =
                    MyRecipesService(provider: AKNetworkProvider<MyRecipesEndpoint>())) {
        self.service = service
    }
    
    // MARK: - MyRecipesProviderProtocol

    func getProfile(
        request: MyRecipesDataFlow.GetMyRecipesData.Request,
        completion: @escaping ((MyRecipesDataFlow.MyRecipesResults) -> Void)
    ) {
        service.getProfile(request: request) {
            switch $0 {
            case let .success(json):
                if let json = User(json: json) {
                    completion(.successful(json))
                } else {
                    completion(.failed(.invalidData))
                }
            case let .failure(error):
                completion(.failed(error))
            }
        }
    }
}
