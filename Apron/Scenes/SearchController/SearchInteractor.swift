//
//  SearchInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 14/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

public protocol SearchBusinessLogic {
    
}

public final class SearchInteractor: SearchBusinessLogic {
    
    // MARK: - Properties
    private let presenter: SearchPresentationLogic
    private let provider: SearchProviderProtocol
    
    // MARK: - Initialization
    public init(presenter: SearchPresentationLogic,
         provider: SearchProviderProtocol = SearchProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - SearchBusinessLogic

}
