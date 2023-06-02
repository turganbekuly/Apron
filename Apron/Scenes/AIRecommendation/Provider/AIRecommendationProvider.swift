//
//  AIRecommendationProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27/05/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import AKNetwork
import Models

protocol AIRecommendationProviderProtocol {
    func getRecipes(
        request: AIRecommendationDataFlow.GetRecommendations.Request,
        completion: @escaping ((AIRecommendationDataFlow.GetRecommendationsResult) -> Void)
    )
}

final class AIRecommendationProvider: AIRecommendationProviderProtocol {

    // MARK: - Properties
    private let service: AIRecommendationServiceProtocol
    
    // MARK: - Init
    init(service: AIRecommendationServiceProtocol =
                    AIRecommendationService(provider: AKNetworkProvider<AIRecommendationEndpoint>())) {
        self.service = service
    }
    
    // MARK: - AIRecommendationProviderProtocol

    func getRecipes(
        request: AIRecommendationDataFlow.GetRecommendations.Request,
        completion: @escaping ((AIRecommendationDataFlow.GetRecommendationsResult) -> Void)
    ) {
        service.getRecipes(request: request) {
            switch $0 {
            case let .success(json):
                if let jsons = SearchAIRecommendationResponseBody(json: json) {
                    completion(.successful(jsons))
                } else {
                    completion(.failed)
                }
            case .failure:
                completion(.failed)
            }
        }
    }
}
