//
//  AIRecommendationInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27/05/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

protocol AIRecommendationBusinessLogic {
    
}

final class AIRecommendationInteractor: AIRecommendationBusinessLogic {
    
    // MARK: - Properties
    private let presenter: AIRecommendationPresentationLogic
    private let provider: AIRecommendationProviderProtocol
    
    // MARK: - Initialization
    init(presenter: AIRecommendationPresentationLogic,
         provider: AIRecommendationProviderProtocol = AIRecommendationProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - AIRecommendationBusinessLogic

}
