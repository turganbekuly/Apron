//
//  AIRecommendationService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27/05/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import AKNetwork
import Models

protocol AIRecommendationServiceProtocol {
    func getRecipes(
        request: AIRecommendationDataFlow.GetRecommendations.Request,
        completion: @escaping ((AKResult) -> Void)
    )
}

final class AIRecommendationService: AIRecommendationServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<AIRecommendationEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<AIRecommendationEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - AIRecommendationServiceProtocol
    
    func getRecipes(
        request: AIRecommendationDataFlow.GetRecommendations.Request,
        completion: @escaping ((AKResult) -> Void)) {
            provider.send(target: .chatGPT(body: request.body)) { result in
                completion(result)
            }
    }
}
