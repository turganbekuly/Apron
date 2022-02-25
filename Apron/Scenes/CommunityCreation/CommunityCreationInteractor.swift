//
//  CommunityCreationInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol CommunityCreationBusinessLogic {
    
}

final class CommunityCreationInteractor: CommunityCreationBusinessLogic {
    
    // MARK: - Properties
    private let presenter: CommunityCreationPresentationLogic
    private let provider: CommunityCreationProviderProtocol
    
    // MARK: - Initialization
    init(presenter: CommunityCreationPresentationLogic,
         provider: CommunityCreationProviderProtocol = CommunityCreationProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - CommunityCreationBusinessLogic

}
