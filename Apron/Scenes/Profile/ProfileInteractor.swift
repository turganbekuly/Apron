//
//  ProfileInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/06/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol ProfileBusinessLogic {
    
}

final class ProfileInteractor: ProfileBusinessLogic {
    
    // MARK: - Properties
    private let presenter: ProfilePresentationLogic
    private let provider: ProfileProviderProtocol
    
    // MARK: - Initialization
    init(presenter: ProfilePresentationLogic,
         provider: ProfileProviderProtocol = ProfileProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - ProfileBusinessLogic

}
