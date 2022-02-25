//
//  SearchInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol SearchBusinessLogic {
    
}

final class SearchInteractor: SearchBusinessLogic {
    
    // MARK: - Properties
    private let presenter: SearchPresentationLogic
    private let provider: SearchProviderProtocol
    
    // MARK: - Initialization
    init(presenter: SearchPresentationLogic,
         provider: SearchProviderProtocol = SearchProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - SearchBusinessLogic

}
